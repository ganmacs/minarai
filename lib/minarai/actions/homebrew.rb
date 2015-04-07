require 'minarai/actions/base'
require 'validator/required_validator.rb'

module Minarai
  module Actions
    class Homebrew < Base
      attribute :item, required: true

      def run
        puts "[START] #{name}..."
        if runnable?
          install
          puts "[DONE] #{name}"
        else
          puts "[FAIL] #{name}"
        end
      end

      private

      def install
        puts "install #{name} #{install_cmd}"
        # run_command install_cmd
      end

      def runnable?
        has_homebrew? && validated? && !installed?
      end

      def installed?
        check_command installed
      end

      def has_homebrew?
        check_command 'which brew'
      end

      def installed
        get_command(:check_package_is_installed, item)
      end

      def install_cmd
        get_command(:install_package, item)
      end
    end
  end
end
