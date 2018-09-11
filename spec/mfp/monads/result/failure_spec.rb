require 'spec_helper'

require 'mfp/monads/result/failure'

module MFP
  module Monads
    class Result

      RSpec.describe Failure do
        let(:dummy) {Object.new}
        let(:wrapped) {'bar'}
        let(:upcase) {:upcase.to_proc}
        subject {described_class.new(wrapped)}

        let(:upcased_subject) {described_class.new('BAR')}

        before(:each) do
          allow(dummy).to receive(:process)
        end

        it_behaves_like 'a monad'

        it { is_expected.not_to be_success }

        it { is_expected.to be_failure }

        it { is_expected.to eql(described_class.new('bar')) }
        it { is_expected.not_to eql(Success.new('bar')) }

        it 'dumps to string' do
          expect(subject.to_s).to eql('Failure("bar")')
        end

        it 'has custom inspection' do
          expect(subject.inspect).to eql('Failure("bar")')
        end

        describe '#bind' do
          it 'accepts a proc and returns itself' do
            expect(subject.bind(upcase)).to be subject
          end

          it 'accepts a block and returns itself' do
            expect(subject.bind { |s| s.upcase }).to be subject
          end

          it 'ignores extra arguments' do
            expect(subject.bind(1, 2, 3) { fail }).to be subject
          end
        end

        describe '#result' do
          subject do
            described_class.new('Foo').result(
              lambda { |v| v.downcase },
              lambda { |v| v.upcase }
            )
          end

          it { is_expected.to eq('foo') }
        end

        describe '#fmap' do
          it 'accepts a proc and returns itself' do
            expect(subject.fmap(upcase)).to be subject
          end

          it 'accepts a block and returns itself' do
            expect(subject.fmap { |s| s.upcase }).to be subject
          end

          it 'ignores arguments' do
            expect(subject.fmap(1, 2, 3) { fail }).to be subject
          end
        end

        describe '#or' do
          it 'accepts a value as an alternative' do
            expect(subject.or('baz')).to eql('baz')
          end

          it 'accepts a block as an alternative' do
            expect(subject.or { 'baz' }).to eql('baz')
          end

          it 'passes extra arguments to a block' do
            expr_result = subject.or(:foo, :bar) do |value, c1, c2|
              expect(value).to eql('bar')
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              'baz'
            end

            expect(expr_result).to eql('baz')
          end
        end

        describe '#or_fmap' do
          it 'maps an alternative' do
            expect(subject.or_fmap('baz')).to eql(Success.new('baz'))
          end

          it 'accepts a block' do
            expect(subject.or_fmap { 'baz' }).to eql(Success.new('baz'))
          end

          it 'passes extra arguments to a block' do
            expr_result = subject.or_fmap(:foo, :bar) do |value, c1, c2|
              expect(value).to eql('bar')
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              'baz'
            end

            expect(expr_result).to eql(Success.new('baz'))
          end
        end

        describe '#to_result' do
          let(:subject) { described_class.new('bar').to_result }

          it 'returns self' do
            is_expected.to eql(described_class.new('bar'))
          end
        end

        describe '#to_maybe' do
          let(:subject) { described_class.new('bar').to_maybe }

          it { is_expected.to be_an_instance_of Maybe::None }
          it { is_expected.to eql(Maybe::None.new) }

          #it 'tracks the caller' do
            #expect(subject.to_maybe.trace).to include("spec/unit/result_spec.rb")
          #end
        end

        describe '#tee' do
          it 'accepts a proc and returns itself' do
            expect(subject.tee(upcase)).to be subject
          end

          it 'accepts a block and returns itself' do
            expect(subject.tee { |s| s.upcase }).to be subject
          end

          it 'ignores arguments' do
            expect(subject.tee(1, 2, 3) { fail }).to be subject
          end
        end

        describe '#flip' do
          it 'transforms Failure to Success' do
            expect(subject.flip).to eql(Success.new('bar'))
          end
        end

        describe '#value_or' do
          it 'returns passed value' do
            expect(subject.value_or('baz')).to eql('baz')
          end

          it 'executes a block' do
            expect(subject.value_or { |bar| 'foo' + bar }).to eql('foobar')
          end
        end

        #describe '#apply' do
          #it 'does nothing' do
            #expect(subject.apply(Success.new('foo'))).to be(subject)
            #expect(subject.apply(described_class.new('foo'))).to be(subject)
          #end
        #end

        describe '#value!' do
          it 'raises an error' do
            expect { subject.value! }.to raise_error(MFP::Monads::UnwrapError)
          end
        end

        describe '#===' do
          it 'matches using the error value' do
            expect(described_class.new('bar')).to be === subject
            expect(described_class.new(/\w+/)).to be === subject
            expect(described_class.new(String)).to be === subject
            expect(described_class.new('foo')).not_to be === subject
          end
        end

        #describe '#to_validated' do
          #it 'returns Invalid' do
            #expect(subject.to_validated).to eql(invalid.call('bar'))
          #end
        #end

        describe '#discard' do
          it 'returns self back' do
            m = described_class.new(1)
            expect(m.discard).to be m
          end
        end


      end

    end
  end
end
