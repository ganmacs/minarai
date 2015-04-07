require 'minarai/actions/base'

module Minarai
  module Actions
    class Git < Base
      attribute :repo, required: true
      attribute :dest, required: true

      def run
        clone
      end

      private

      def runnable?
        has_git? && validate? && !existed?
      end

      def clone
        puts 'clone'
        # run_command("git clone #{repo} #{dest}")
      end

      def existed?
        check_specific_command(:check_file_is_directory, dest)
      end

      def has_git?
        check_command 'which git'
      end

      def name
        super || "clone #{repo} to #{dest}"
      end
    end
  end
end
