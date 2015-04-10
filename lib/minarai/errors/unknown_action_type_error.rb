require 'minarai/errors/base'

module Minarai
  module Errors
    class UnknownActionTypeError < Base
      def initialize(type)
        @type = type
      end

      def to_s
        "`type` : #{@type} is unknown"
      end
    end
  end
end
