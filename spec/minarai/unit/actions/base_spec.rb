require 'minarai/actions/base'

describe Minarai::Actions::Base do
  describe '::attribute' do
    let(:klass) do
      Class.new(Minarai::Actions::Base) do |_|
        attribute :destination, required: true, type: String
        def run
        end

        def complete?
        end
      end
    end

    context 'when valid attribute is recieved' do
      let(:klass_obj) { klass.new('destination' => 'path') }
      it { expect(klass_obj.error_messages).to eq [] }
    end

    context 'when required attribute is not existed' do
      let(:klass_obj) { klass.new({}) }
      it { expect(klass_obj.error_messages.first).to be_a Minarai::Errors::AttributeValidationError }
    end
  end
end
