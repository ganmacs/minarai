require 'minarai/actions/base'

module Minarai
  module Actions
    class Git < Base
      attribute :repository, required: true

      def run
        clone
      end

      private

      def runnable?
        has_git? && validated? && !existed?
      end

      def clone
        puts 'clone'
        # run_command("git clone #{repo} #{dest}")
      end

      def existed?
        check_specific_command(:check_file_is_directory, destination)
      end

      def has_git?
        check_command 'which git'
      end

      def name
        super || "clone #{repository} to #{destination}"
      end
    end
  end
end
