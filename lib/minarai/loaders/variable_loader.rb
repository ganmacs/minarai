require 'minarai/loaders/base'
require 'minarai/variable'

module Minarai
  module Loaders
    class VariableLoader < Base
      private

      def loaded_class
        Minarai::Variable
      end
    end
  end
end
