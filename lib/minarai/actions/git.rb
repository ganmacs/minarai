require 'minarai/actions/base'
require 'validator/required_validator.rb'

module Minarai
  module Actions
    class Git < Base
      attribute :repo, required: true
      attribute :dest, required: true

      def run
        puts "[START] #{name}..."
        if runnable?
          clone
          puts "[DONE] #{name}"
        else
          puts "[FAIL] #{name}"
        end
      end

      private

      def runnable?
        has_git? && validate? && !existed?
      end

      def clone
        p 'clone'
        # run_command("git clone #{repo} #{dest}")
      end

      def existed?
        check_command existed_file
      end

      def has_git?
        check_command 'which git'
      end

      def name
        super || "clone #{repo} to #{dest}"
      end

      def existed_file
        get_command(:check_file_is_directory, dest)
      end
    end
  end
end
