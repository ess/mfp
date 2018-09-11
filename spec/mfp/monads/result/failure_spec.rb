require 'spec_helper'

require 'mfp/monads/result/failure'

module MFP
  module Monads
    class Result

      RSpec.describe Failure do
        let(:dummy) {Object.new}
        let(:wrapped) {3}
        subject {described_class.new(wrapped)}

        before(:each) do
          allow(dummy).to receive(:process)
        end

        it_behaves_like 'a monad'

        it 'is a result' do
          expect(subject).to be_a(Result)
        end

        it 'is frozen' do
          expect(subject).to be_frozen
        end

        describe '#success?' do
          let(:success) {subject.success?}

          it 'is false' do
            expect(success).to eql(false)
          end
        end

        describe '#failure?' do
          let(:failure) {subject.failure?}

          it 'is true' do
            expect(failure).to eql(true)
          end
        end

        describe '#failure' do
          let(:error) {subject.failure}

          it 'is the wrapped error' do
            expect(error).to eql(wrapped)
          end
        end

        describe '#bind' do
          it 'does not execute the given block' do
            expect(dummy).not_to receive(:process)

            subject.bind {|v| dummy.process(v)}
          end

          it 'is the failure itself' do
            actual = subject.bind {|v| v}

            expect(actual).to eql(subject)
          end
        end

        describe '#or' do
          it 'yields the wrapped value to the block' do
            expect(dummy).to receive(:process).with(wrapped)

            subject.or {|v| dummy.process(v)}
          end

          it 'is the result of the block' do
            actual = subject.or {|v| v + 1}

            expect(actual).to eql(wrapped + 1)
          end
        end

        describe '#to_result' do
          it 'is the failure itself' do
            expect(subject.to_result).to eql(subject)
          end
        end

        describe '#value!' do
          it 'raises an unwrap error' do
            expect {subject.value!}.
              to raise_error(MFP::Monads::UnwrapError)
          end
        end

      end

    end
  end
end
