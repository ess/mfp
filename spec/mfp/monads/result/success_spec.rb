require 'spec_helper'

require 'mfp/monads/result/success'

module MFP
  module Monads
    class Result

      RSpec.describe Success do
        let(:dummy) {Object.new}
        let(:wrapped) {3}
        let(:result) {described_class.new(wrapped)}

        before(:each) do
          allow(dummy).to receive(:process)
        end

        it 'is a result' do
          expect(result).to be_a(Result)
        end

        describe '#success?' do
          let(:success) {result.success?}

          it 'is true' do
            expect(success).to eql(true)
          end
        end

        describe '#failure?' do
          let(:failure) {result.failure?}

          it 'is false' do
            expect(failure).to eql(false)
          end
        end

        describe '#value' do
          let(:value) {result.value}

          it 'is the wrapped value' do
            expect(value).to eql(wrapped)
          end
        end

        describe '#bind' do
          it 'yields the wrapped value to the block' do
            expect(dummy).to receive(:process).with(wrapped)

            result.bind {|v| dummy.process(v)}
          end

          it 'is the result of yielding the wrapped value to the block' do
            actual = result.bind {|v| v + 1}

            expect(actual).to eql(wrapped + 1)
          end
        end

        describe '#or' do
          it 'does not call the block' do
            expect(dummy).not_to receive(:process)

            result.or {|v| dummy.process(v)}
          end

          it 'is the success itself' do
            actual = result.or {|v| v}

            expect(actual).to eql(result)
          end
        end

        describe '#to_result' do
          it 'is the success itself' do
            expect(result.to_result).to eql(result)
          end
        end

      end

    end
  end
end
