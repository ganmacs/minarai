require 'minarai/action_builder'
require 'minarai/actions/git'
require 'minarai/actions/unknown'

describe Minarai::ActionBuilder do
  describe '#build' do
    context 'when valid action type recieved' do
      subject { described_class.new('type' => 'git').build}
      it 'return valid ActionType' do
        is_expected.to be_a Minarai::Actions::Git
      end
    end

    context 'when invalid action type recieved' do
      subject { described_class.new('type' => 'invalid').build }
      it 'return Minrai::Actions::Unknown' do
        is_expected.to be_a Minarai::Actions::Unknown
      end
    end
  end
end
