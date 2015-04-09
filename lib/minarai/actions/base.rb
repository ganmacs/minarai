require 'active_model'
require 'validator/required_validator'
require 'validator/type_validator'
require 'minarai/errors/attribute_validation_error'
require 'minarai/logger'

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
        if complete?
          Minarai::Logger.skip "[SKIP] #{name}"
        else
          run
          if complete?
            Minarai::Logger.done "[DONE] #{name}"
          else
            Minarai::Logger.fail "[FAIL] #{name}"
          end
        end
      end

      def run
        raise NotImplementedError
      end

      def error_messages
        validation_error_messages
      end

      private

      def complete?
        raise NotImplementedError
      end

      def validated?
        validate
      end

      def validation_error_messages
        validate
        errors.map do |attribute, error_message|
          Minarai::Errors::AttributeValidationError.new(attribute, error_message, name)
        end
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

      def run_specific_command(method, *args)
        run_command(backend.command.get(method, *args))
      end

      def check_specific_command(method, *args)
        run_specific_command(method, *args).success?
      end
    end
  end
end
