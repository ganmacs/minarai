require 'minarai/actions/base'

module Minarai
  module Actions
    class Link < Base
      attribute :destination, required: true, type: String
      attribute :source, required: true, type: String

      def call
        abort_with_runtime_error unless runnable?
        super
      end

      def run
        link
      end

      private

      def link
        puts 'link'
        # run_specific_command(:link_file_to, destination, source)
      end

      def complete?
        existed_file?
      end

      def readable_source?
        !source.nil? && ::File.readable?(source)
      end

      def runnable?
        readable_source?
      end

      def abort_with_runtime_error
        Minarai::Logger.errorr(runtime_error) and abort
      end

      def runtime_error
        Minarai::Errors::AttributeValidationError.new('source', 'is not readable file', name)
      end

      def existed_file?
        check_specific_command(:check_file_is_linked_to, destination, source)
      end

      def name
        super || "create symlink #{repository} to #{destination}"
      end
    end
  end
end
