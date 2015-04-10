require 'minarai/actions/base'
require 'minarai/errors/unknown_action_type_error'

module Minarai
  module Actions
    class Unknown < Base
      def run
        # override
      end

      def error_messages
        [Minarai::Errors::UnknownActionTypeError.new(type)]
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
