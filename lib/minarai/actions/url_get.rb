require 'minarai/actions/base'

module Minarai
  module Actions
    class UrlGet < Base
      attribute :source, required: true, type: String
      attribute :destination, required: true, type: String

      def run
        url_get
      end

      private

      def url_get
        run_command("curl -o #{destination} #{source}")
      end

      def complete?
        has_url_get? && existed?
      end

      def existed?
        %i(check_file_is_file check_file_is_directory).any? do |command|
          check_specific_command(command, destination)
        end
      end

      def has_url_get?
        check_command 'which curl'
      end

      def name
        super || "url-get form #{source} to #{destination}"
      end
    end
  end
end
