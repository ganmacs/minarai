require 'active_model'
require 'validator/required_validator.rb'

module Minarai
  module Actions
    class Base
      class << self
        def attribute(name, options = {})
          default = options.delete(:default)
          define_method(name) do
            @attributes[name.to_s] || default
          end
          validates name, options
        end
      end

      include ActiveModel::Validations

      attr_accessor :backend

      def initialize(attributes)
        @attributes = attributes
      end

      def call
        puts "[START] #{name}..."
        if runnable?
          run
          puts "[DONE] #{name}"
        else
          puts "[FAIL] #{name}"
        end
      end

      def run
        raise NotImplementedError
      end

      private

      def runnable?
        raise NotImplementedError
      end

      def has_command?
        raise NotImplementedError
      end

      def validated?
        validate
      end

      def name
        @attributes['name']
      end

      def run_command(*args)
        backend.run_command(*args)
      end

      def check_command(*args)
        run_command(*args).success?
      end

      # なまえ
      def run_specific_command(method, *args)
        run_command(backend.command.get(method, *args))
      end

      def check_specific_command(method, *args)
        run_specific_command(method, *args).success?
      end
    end
  end
end
