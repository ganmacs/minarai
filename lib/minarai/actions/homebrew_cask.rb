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
        puts name
        # run_command "brew cask install #{item}"
      end

      def complete?
        has_homebrew? && installed?
      end

      def installed?
        check_command "/usr/local/bin/brew cask list -1 | grep -E '^#{item}$'"
      end

      def has_homebrew?
        check_command 'which brew-cask'
      end

      def name
        super || "brew cask install #{item}"
      end
    end
  end
end
