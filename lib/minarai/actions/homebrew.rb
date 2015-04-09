require 'minarai/actions/base'

module Minarai
  module Actions
    class Homebrew < Base
      attribute :item, required: true

      def run
        install
      end

      private

      def install
        run_specific_command(:install_package, item)
      end

      def complete?
        has_homebrew? && installed?
      end

      def installed?
        check_specific_command(:check_package_is_installed, item)
      end

      def has_homebrew?
        check_command 'which brew'
      end

      def name
        super || "brew install #{item}"
      end
    end
  end
end
