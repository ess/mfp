require 'spec_helper'

require 'mfp/monads/maybe/none'

module MFP
  module Monads
    class Maybe

      RSpec.describe None do
        let(:upcase) {:upcase.to_proc}
        subject {described_class.new}

        it_behaves_like 'a monad'

        it { is_expected.not_to be_some }
        it { is_expected.to be_none }

        it { is_expected.to eql(described_class.new) }
        it { is_expected.not_to eql(Some.new('foo')) }

        it 'dumps to string' do
          expect(subject.to_s).to eql('None')
        end

        it 'has custom inspection' do
          expect(subject.inspect).to eql('None')
        end

        #describe '#initialize' do
          #it 'traces the caller' do
            #expect(subject.trace).to include("spec/unit/maybe_spec.rb")
          #end
        #end

        describe '#value!' do
          it 'raises an error' do
            expect { subject.value! }.to raise_error(MFP::Monads::UnwrapError)
          end
        end

        describe '#bind' do
          it 'accepts a proc and returns itself' do
            expect(subject.bind(upcase)).to be subject
          end

          it 'accepts a block and returns itself' do
            expect(subject.bind { |s| s.upcase }).to be subject
          end

          it 'ignores arguments' do
            expect(subject.bind(1, 2, 3) { fail }).to be subject
          end
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
            result = subject.or(:foo, :bar) do |c1, c2|
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              'baz'
            end

            expect(result).to eql('baz')
          end
        end

        describe '#or_fmap' do
          it 'maps an alternative' do
            expect(subject.or_fmap('baz')).to eql(Some.new('baz'))
          end

          it 'accepts a block' do
            expect(subject.or_fmap { 'baz' }).to eql(Some.new('baz'))
          end

          it 'passes extra arguments to a block' do
            result = subject.or_fmap(:foo, :bar) do |c1, c2|
              expect(c1).to eql(:foo)
              expect(c2).to eql(:bar)
              'baz'
            end

            expect(result).to eql(Some.new('baz'))
          end

          it 'tranforms nil to None' do
            expect(subject.or_fmap(nil)).to eql(described_class.new)
          end
        end

        describe '#value_or' do
          it 'returns passed value' do
            expect(subject.value_or('baz')).to eql('baz')
          end

          it 'executes a block' do
            expect(subject.value_or { 'bar' }).to eql('bar')
          end
        end

        describe '#to_maybe' do
          let(:subject) { None.new.to_maybe }

          it { is_expected.to eql described_class.new }
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

        describe '#some?/#success?' do
          it 'returns true' do
            expect(subject).not_to be_some
            expect(subject).not_to be_success
          end
        end

        describe '#none?/#failure?' do
          it 'returns false' do
            expect(subject).to be_none
            expect(subject).to be_failure
          end
        end

        #describe '#apply' do
          #it 'does nothing' do
            #expect(subject.apply(some['foo'])).to be(subject)
            #expect(subject.apply(none)).to be(subject)
          #end
        #end

        describe '#===' do
          it 'matches against other None' do
            expect(described_class.new).to be === described_class.new
          end

          it "doesn't match a Some" do
            expect(described_class.new).not_to be === Some.new('foo')
          end
        end

        describe '#discard' do
          it 'returns self back' do
            expect(subject.discard).to be subject
          end
        end


      end
    end
  end
end
