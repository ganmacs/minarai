require 'minarai/actions/base'

module Minarai
  module Actions
    class HomebrewCask < Base
      attribute :item, required: true

      def run
        install
      end

      private

      def install
        puts "install #{name} #{install_cmd}"
        # run_command "brew cask install #{item}"
      end

      def runnable?
        has_homebrew? && validated? && !installed?
      end

      def installed?
        check_command "/usr/local/bin/brew cask list -1 | grep -E '^#{item}$'"
      end

      def has_homebrew?
        check_command 'which brew-cask'
      end
    end
  end
end
