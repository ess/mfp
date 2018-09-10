require 'spec_helper'

require 'mfp/result/failure'

module MFP
  class Result

    RSpec.describe Failure do
      let(:dummy) {Object.new}
      let(:wrapped) {3}
      let(:result) {described_class.new(wrapped)}

      before(:each) do
        allow(dummy).to receive(:process)
      end

      it 'is a result' do
        expect(result).to be_a(Result)
      end

      it 'is frozen' do
        expect(result).to be_frozen
      end

      describe '#success?' do
        let(:success) {result.success?}

        it 'is false' do
          expect(success).to eql(false)
        end
      end

      describe '#failure?' do
        let(:failure) {result.failure?}

        it 'is true' do
          expect(failure).to eql(true)
        end
      end

      describe '#value' do
        let(:value) {result.value}

        it 'raises an exception' do
          expect {value}.to raise_exception
        end
      end

      describe '#failure' do
        let(:error) {result.failure}

        it 'is the wrapped error' do
          expect(error).to eql(wrapped)
        end
      end

      describe '#bind' do
        it 'does not execute the given block' do
          expect(dummy).not_to receive(:process)

          result.bind {|v| dummy.process(v)}
        end

        it 'is the failure itself' do
          actual = result.bind {|v| v}

          expect(actual).to eql(result)
        end
      end

      describe '#or' do
        it 'yields the wrapped value to the block' do
          expect(dummy).to receive(:process).with(wrapped)

          result.or {|v| dummy.process(v)}
        end

        it 'is the result of the block' do
          actual = result.or {|v| v + 1}

          expect(actual).to eql(wrapped + 1)
        end
      end

      describe '#to_result' do
        it 'is the failure itself' do
          expect(result.to_result).to eql(result)
        end
      end

    end

  end
end
