require 'minarai/variable'

describe Minarai::Variable do
  let(:variable) { described_class.new(hoge: 'fuga', fuga: 'hoge') }

  describe '#to_mash' do
    it 'return Minarai::Variable::MashedVariable object' do
      expect(variable.to_mash).to be_a Minarai::Variable::MashedVariable
    end
  end
end
