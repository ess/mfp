require 'spec_helper'

require 'mfp/monads/maybe/some'

module MFP
  module Monads
    class Maybe

      RSpec.describe Some do
        let(:dummy) {Object.new}
        let(:wrapped) {3}
        let(:maybe) {described_class.new(wrapped)}

        before(:each) do
          allow(dummy).to receive(:process)
        end

        it 'is a maybe' do
          expect(maybe).to be_a(Maybe)
        end

        describe '#some?' do
          let(:some) {maybe.some?}

          it 'is true' do
            expect(some).to eql(true)
          end
        end

        describe '#none?' do
          let(:none) {maybe.none?}

          it 'is false' do
            expect(none).to eql(false)
          end
        end

        describe '#value' do
          let(:value) {maybe.value}

          it 'is the wrapped value' do
            expect(value).to eql(wrapped)
          end
        end

        describe '#error' do
          let(:error) {maybe.error}

          it 'raises an exception' do
            expect {error}.to raise_exception
          end
        end

        describe '#bind' do
          it 'yields the wrapped value to the block' do
            expect(dummy).to receive(:process).with(wrapped)

            maybe.bind {|v| dummy.process(v)}
          end

          it 'is the maybe of yielding the wrapped value to the block' do
            actual = maybe.bind {|v| v + 1}

            expect(actual).to eql(wrapped + 1)
          end
        end

        describe '#or' do
          it 'does not call the block' do
            expect(dummy).not_to receive(:process)

            maybe.or {|v| dummy.process(v)}
          end

          it 'is the success itself' do
            actual = maybe.or {|v| v}

            expect(actual).to eql(maybe)
          end
        end

        describe '#to_maybe' do
          it 'is the some itself' do
            expect(maybe.to_maybe).to eql(maybe)
          end
        end

        describe '#to_monad' do
          it 'is the some itself' do
            expect(maybe.to_monad).to eql(maybe)
          end
        end

      end

    end
  end
end
