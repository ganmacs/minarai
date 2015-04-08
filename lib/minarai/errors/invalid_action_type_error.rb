require 'minarai/errors/base'

module Minarai
  module Errors
    class InvalidActionTypeError < Base
      def initialize(name)
        @name = name
      end

      def to_s
        "`type` is required @ #{@name}"
      end
    end
  end
end
