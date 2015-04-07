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
        # run_specific_command(:install_package, item)
      end

      def runnable?
        has_homebrew? && validated? && !installed?
      end

      def installed?
        check_specific_command(:check_package_is_installed, item)
      end

      def has_homebrew?
        check_command 'which brew'
      end
    end
  end
end
