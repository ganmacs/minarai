require 'minarai/errors/base'

module Minarai
  module Errors
    class AttributeValidationError < Base
      def initialize(attribute, error_message, name)
        @attribute = attribute
        @error_message = error_message
        @name = name
      end

      def to_s
        "[error] `#{@attribute}` #{@error_message} @ #{@name}"
      end
    end
  end
end
