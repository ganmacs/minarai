require 'minarai/actions/base'
require 'minarai/errors/invalid_action_type_error'

module Minarai
  module Actions
    class Unknown < Base
      def run
        # override
      end

      def error_messages
        [Minarai::Errors::InvalidActionTypeError.new(name)]
      end

      private

      def complete?
        # override
      end

      def name
        super || 'unknow action'
      end
    end
  end
end
