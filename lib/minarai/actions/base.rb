require 'active_model'
require 'validator/required_validator.rb'
require 'validator/type_validator.rb'
require 'validator/readable_validator.rb'

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
        puts '***************************'
        puts "[START] #{name}..."


        if complete?
          puts "[SKIP] #{name}"
        else
          run
          status = complete? ? 'DONE' : 'FAIL'
          puts "[#{status}] #{name}"
        end

        puts '***************************'
        puts
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
        validate                # @TODO want to remove
        errors.map do |attribute, error_message|
          "#{attribute} #{error_message}"
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
