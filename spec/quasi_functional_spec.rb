RSpec.describe QuasiFunctional do
  it "has a version number" do
    expect(QuasiFunctional::VERSION).not_to be nil
  end

  describe '.Result' do
    it 'is the Result DSL' do
      expect(described_class.Result).to eql(described_class::Result::DSL)
    end
  end

  describe '.Railway' do
    it 'is the Railway module' do
      expect(described_class.Railway).to eql(described_class::Railway)
    end
  end

end
