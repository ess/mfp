RSpec.shared_examples_for 'an applicative' do
  describe '.pure' do
    it 'wraps the value with a context' do
      expect(described_class.pure(1)).to eql(pure.(1))
    end

    it 'wraps a block' do
      fn = lambda {|x| x + 1}
      expect(described_class.pure(&fn)).to eql(pure.(fn))
    end
  end
end
