require 'minarai/recipe'
require 'minarai/loaders/base'
require 'minarai/loaders/variable_loader'
require 'minarai/variable'

module Minarai
  module Loaders
    class RecipeLoader < Base
      def initialize(path, variable_path: nil)
        super(path)
        @variable_path = variable_path
      end

      private

      def loaded_class
        Minarai::Recipe
      end

      def has_variable_path?
        !@variable_path.nil?
      end

      def binding_for_erb
        variables.to_mash.binding
      end

      def variables
        @variables ||= begin
          if has_variable_path?
            Minarai::Loaders::VariableLoader.new(@variable_path).load
          else
            Minarai::Variable.new({})
          end
        end
      end
    end
  end
end
