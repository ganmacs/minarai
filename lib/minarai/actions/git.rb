require 'minarai/actions/base'

module Minarai
  module Actions
    class Git < Base
      attribute :repository, required: true
      attribute :destination, required: true

      def run
        clone
      end

      private

      def complete?
        has_git? && existed?
      end

      def clone
        puts 'clone'
        # run_command("git clone #{repository} #{destination}")
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
