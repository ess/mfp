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



      end

    end
  end
end
