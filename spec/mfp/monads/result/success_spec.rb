require 'spec_helper'

require 'mfp/monads/result/success'

module MFP
  module Monads
    class Result

      RSpec.describe Success do
        let(:dummy) {Object.new}
        let(:wrapped) {'foo'}
        let(:upcase) {:upcase.to_proc}
        subject {described_class.new(wrapped)}

        let(:upcased_subject) {described_class.new('FOO')}

        before(:each) do
          allow(dummy).to receive(:process)
        end

        it_behaves_like 'an applicative' do
          let(:pure) {described_class.method(:new)}
        end

        it_behaves_like 'a monad'

        it 'dumps to string' do
          expect(subject.to_s).to eql('Success("foo")')
        end

        it 'has custom inspection' do
          expect(subject.inspect).to eql('Success("foo")')
        end

        describe '#bind' do
          it 'accepts a proc and does not lift the result' do
            expect(subject.bind(upcase)).to eql('FOO')
          end

          it 'accepts a block too' do
            expect(subject.bind { |s| s.upcase }).to eql('FOO')
          end

          it 'passes extra arguments to a block' do
            expr_result = subject.bind(:foo) do |value, c|
              expect(value).to eql('foo')
              expect(c).to eql(:foo)
              true
            end

            expect(expr_result).to be true
          end

          it 'passes extra arguments to a proc' do
            proc = lambda do |value, c|
              expect(value).to eql('foo')
              expect(c).to eql(:foo)
              true
            end

            expr_result = subject.bind(proc, :foo)

            expect(expr_result).to be true
          end
        end

        #describe '#result' do
          #subject do
            #described_class.new('Foo').result(
              #lambda { |v| v.downcase },
              #lambda { |v| v.upcase }
            #)
          #end

          #it { is_expected.to eq('FOO') }
        #end

        describe '#fmap' do
          it 'accepts a proc and lifts the result to Result' do
            expect(subject.fmap(upcase)).to eql(upcased_subject)
          end

          it 'accepts a block too' do
            expect(subject.fmap { |s| s.upcase }).to eql(upcased_subject)
          end

          it 'passes extra arguments to a block' do
            expr_result = subject.fmap(:foo, :bar) do |value, c1, c2|
              expect(value).to eql('foo')
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              true
            end

            expect(expr_result).to eql(described_class.new(true))
          end

          it 'passes extra arguments to a proc' do
            proc = lambda do |value, c1, c2|
              expect(value).to eql('foo')
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              true
            end

            expr_result = subject.fmap(proc, :foo, :bar)

            expect(expr_result).to eql(described_class.new(true))
          end
        end

        describe '#or' do
          it 'accepts value as an alternative' do
            expect(subject.or('baz')).to be(subject)
          end

          it 'accepts block as an alternative' do
            expect(subject.or { fail }).to be(subject)
          end

          it 'ignores all values' do
            expect(subject.or(:foo, :bar, :baz) { fail }).to be(subject)
          end
        end

        describe '#or_fmap' do
          it 'accepts value as an alternative' do
            expect(subject.or_fmap('baz')).to be(subject)
          end

          it 'accepts block as an alternative' do
            expect(subject.or_fmap { fail }).to be(subject)
          end

          it 'ignores all values' do
            expect(subject.or_fmap(:foo, :bar, :baz) { fail }).to be(subject)
          end
        end

        describe '#to_result' do
          subject { described_class.new('foo').to_result }

          it 'returns self' do
            is_expected.to eql(described_class.new('foo'))
          end
        end

        #describe '#to_maybe' do
          #subject { described_class.new('foo').to_maybe }

          #it { is_expected.to be_an_instance_of maybe::Some }
          #it { is_expected.to eql(some['foo']) }

          #context 'value is nil' do
            #around { |ex| suppress_warnings { ex.run } }
            #subject { described_class.new(nil).to_maybe }

            #it { is_expected.to be_an_instance_of maybe::None }
            #it { is_expected.to eql(maybe::None.new) }
          #end
        #end

        describe '#tee' do
          it 'passes through itself when the block returns a Success' do
            expect(subject.tee(lambda { described_class.new('ignored') })).to eql(subject)
          end

          it 'returns the block result when it is a Failure' do
            expect(subject.tee(lambda { Failure.new('failure') })).
              to be_an_instance_of Failure
          end
        end

        describe '#value_or' do
          it 'returns existing value' do
            expect(subject.value_or('baz')).to eql(subject.value!)
          end

          it 'ignores a block' do
            expect(subject.value_or { 'baz' }).to eql(subject.value!)
          end
        end

        #describe '#to_validated' do
          #it 'returns Valid' do
            #expect(subject.to_validated).to eql(valid.('foo'))
          #end
        #end


        #it 'is a result' do
          #expect(subject).to be_a(Result)
        #end

        #describe '#success?' do
          #let(:success) {subject.success?}

          #it 'is true' do
            #expect(success).to eql(true)
          #end
        #end

        #describe '#failure?' do
          #let(:failure) {subject.failure?}

          #it 'is false' do
            #expect(failure).to eql(false)
          #end
        #end

        #describe '#value' do
          #let(:value) {subject.value}

          #it 'is the wrapped value' do
            #expect(value).to eql(wrapped)
          #end
        #end

        #describe '#bind' do
          #it 'yields the wrapped value to the block' do
            #expect(dummy).to receive(:process).with(wrapped)

            #subject.bind {|v| dummy.process(v)}
          #end

          #it 'is the result of yielding the wrapped value to the block' do
            #actual = subject.bind {|v| v + 'l'}

            #expect(actual).to eql(wrapped + 'l')
          #end
        #end

        #describe '#or' do
          #it 'does not call the block' do
            #expect(dummy).not_to receive(:process)

            #subject.or {|v| dummy.process(v)}
          #end

          #it 'is the success itself' do
            #actual = subject.or {|v| v}

            #expect(actual).to eql(subject)
          #end
        #end

        #describe '#to_result' do
          #it 'is the success itself' do
            #expect(subject.to_result).to eql(subject)
          #end
        #end

        #describe '#fmap' do
          #it 'accepts a proc and lifts the result to Result' do
            #expect(subject.fmap(upcase)).to eql(upcased_subject)
          #end

          #it 'accepts a block too' do
            #expect(subject.fmap {|s| s.upcase}).to eql(upcased_subject)
          #end

          #it 'passes extra arguments to a block' do
            #expr_result = subject.fmap(:foo, :bar) do |value, c1, c2|
              #expect(value).to eql(wrapped)
              #expect(c1).to eql(:foo)
              #expect(c2).to eql(:bar)
              #true
            #end

            #expect(expr_result).to eql(described_class.new(true))
          #end

          #it 'passes extra arguments to a proc' do
            #proc = lambda do |value, c1, c2|
              #expect(value).to eql(wrapped)
              #expect(c1).to eql(:foo)
              #expect(c2).to eql(:bar)
              #true
            #end

            #expr_result = subject.fmap(proc, :foo, :bar)

            #expect(expr_result).to eql(described_class.new(true))
          #end
        #end

      end

    end
  end
end
