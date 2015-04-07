require 'minarai/actions/base'
require 'validator/required_validator.rb'

module Minarai
  module Actions
    class HomebrewCask < Base
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
        run_command install_cmd
      end

      def runnable?
        has_homebrew? && validated? && !installed?
      end

      def installed?
        check_command installed
      end

      def has_homebrew?
        check_command 'which brew-cask'
      end

      def installed
        "/usr/local/bin/brew cask list -1 | grep -E '^#{item}$'"
      end

      def install_cmd
        run_command("brew cask install #{item}")
      end
    end
  end
end
