require 'spec_helper'

require 'mfp/monads/maybe/some'

module MFP
  module Monads
    class Maybe

      RSpec.describe Some do
        let(:dummy) {Object.new}
        let(:upcase) {:upcase.to_proc}
        let(:wrapped) {'foo'}
        subject {described_class.new(wrapped)}
        let(:upcased_subject) { described_class.new('FOO') }

        before(:each) do
          allow(dummy).to receive(:process)
        end

        it_behaves_like 'a monad'

        it_behaves_like 'an applicative' do
          let(:pure) {described_class.method(:new)}
        end

        it {is_expected.to be_some}
        it {is_expected.not_to be_none}
        it {is_expected.to eql(described_class.new('foo'))}
        it {is_expected.not_to eql(None.instance)}

        it 'dumps to a string' do
          expect(subject.to_s).to eql('Some("foo")')
        end

        it 'has custom inspection' do
          expect(subject.inspect).to eql('Some("foo")')
        end

        describe '.to_proc' do
          it 'returns a constructor block' do
            expect(described_class.to_proc.call('foo')).to eql(subject)
          end
        end


        describe '#bind' do
          it 'accepts a proc and does not lift the result' do
            expect(subject.bind(upcase)).to eql('FOO')
          end

          it 'accepts a block too' do
            expect(subject.bind { |s| s.upcase }).to eql('FOO')
          end

          it 'passes extra arguments to a block' do
            result = subject.bind(:foo) do |value, c|
              expect(value).to eql('foo')
              expect(c).to eql(:foo)
              true
            end

            expect(result).to be true
          end

          it 'passes extra arguments to a proc' do
            proc = lambda do |value, c|
              expect(value).to eql('foo')
              expect(c).to eql(:foo)
              true
            end

            result = subject.bind(proc, :foo)

            expect(result).to be true
          end
        end

        describe '#value!' do
          it 'unwraps the value' do
            expect(subject.value!).to eql('foo')
          end
        end

        describe '#fmap' do
          it 'accepts a proc and does not lift the result to maybe' do
            expect(subject.fmap(upcase)).to eql(upcased_subject)
          end

          it 'accepts a block too' do
            expect(subject.fmap { |s| s.upcase }).to eql(upcased_subject)
          end

          it 'passes extra arguments to a block' do
            result = subject.fmap(:foo, :bar) do |value, c1, c2|
              expect(value).to eql('foo')
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              true
            end

            expect(result).to eql(described_class.new(true))
          end

          it 'passes extra arguments to a proc' do
            proc = lambda do |value, c1, c2|
              expect(value).to eql('foo')
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              true
            end

            result = subject.fmap(proc, :foo, :bar)

            expect(result).to eql(described_class.new(true))
          end
        end

        describe '#or' do
          it 'accepts a value as an alternative' do
            expect(subject.or(described_class.new('baz'))).to be(subject)
          end

          it 'accepts a block as an alternative' do
            expect(subject.or { fail }).to be(subject)
          end

          it 'ignores all values' do
            expect(subject.or(:foo, :bar, :baz) { fail }).to be(subject)
          end
        end

        describe '#or_fmap' do
          it 'accepts a value as an alternative' do
            expect(subject.or_fmap('baz')).to be(subject)
          end

          it 'accepts a block as an alternative' do
            expect(subject.or_fmap { fail }).to be(subject)
          end

          it 'ignores all values' do
            expect(subject.or_fmap(:foo, :bar, :baz) { fail }).to be(subject)
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

        describe '#to_maybe' do
          let(:subject) { described_class.new('foo').to_maybe }

          it { is_expected.to eql described_class.new('foo') }
        end

        describe '#tee' do
          it 'passes through itself when the block returns a Right' do
            expect(subject.tee(lambda { described_class.new('ignored') })).
              to be(subject)
          end

          it 'returns the block result when it is None' do
            expect(subject.tee(lambda { None.new })).to be_none
          end
        end

        describe '#some?/#success?' do
          it 'returns true' do
            expect(subject).to be_some
            expect(subject).to be_success
          end
        end

        describe '#none?/#failure?' do
          it 'returns false' do
            expect(subject).not_to be_none
            expect(subject).not_to be_failure
          end
        end

        #describe '#apply' do
          #subject { some[:upcase.to_proc] }

          #it 'applies a wrapped function' do
            #expect(subject.apply(some['foo'])).to eql(some['FOO'])
            #expect(subject.apply(none)).to eql(none)
          #end
        #end

        describe '#===' do
          it 'matches on the wrapped value' do
            expect(described_class.new('foo')).
              to be === described_class.new('foo')
            expect(described_class.new(/\w+/)).
              to be === described_class.new('foo')
            expect(described_class.new(:bar)).
              not_to be === described_class.new('foo')
            expect(described_class.new(10..50)).
              to be === described_class.new(42)
          end
        end

        describe '#discard' do
          it 'nullifies the value' do
            expect(described_class.new('foo').discard).
              to eql(described_class.new(Unit))
          end
        end




      end

    end
  end
end
