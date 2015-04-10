require 'minarai/actions/base'

module Minarai
  module Actions
    class Rbenv < Base
      attribute :version, required: true, type: String
      attribute :global, type: [TrueClass, FalseClass], default: true

      def run
        install_specific_ruby_version unless has_specific_ruby_version?
        set_global_ruby_version unless set_specific_ruby_version?
      end

      private

      def install_specific_ruby_version
        run_command "rbenv install #{version}"
      end

      def complete?
        has_rbenv? && has_specific_ruby_version? && set_specific_ruby_version?
      end

      def has_rbenv?
        check_command 'which rbenv'
      end

      def has_specific_ruby_version?
        check_command "rbenv prefix #{version}"
      end

      def set_valid_glbal_ruby_version?
        global_version == version
      end

      def global_version
        run_command('rbenv global').stdout.rstrip
      end

      def set_specific_ruby_version?
        check_command "rbenv global #{version}"
      end

      def name
        super || "rbenv install ruby version #{version}"
      end
    end
  end
end
