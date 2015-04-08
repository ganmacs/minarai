require 'minarai/actions/base'

module Minarai
  module Actions
    class Link < Base
      attribute :destination, required: true, type: String
      attribute :source, required: true, type: String

      def call
        if readable_source?
          super
        else
          puts "[ERROR] #{source} is not readable file"
        end
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

      def existed_file?
        check_specific_command(:check_file_is_linked_to, destination, source)
      end

      def name
        super || "create symlink #{repository} to #{destination}"
      end
    end
  end
end
