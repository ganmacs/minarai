require 'slop'
require 'minarai/loaders/recipe_loader'

module Minarai
  class Command
    def initialize(args)
      @args = args
    end

    def call
      abort_with_error_message unless recipe.valid?
      recipe.runner.run
    end

    private

    def abort_with_error_message
      abort recipe.errors.map { |error| "Error: #{error}" }.join("\n")
    end

    def recipe
      @recipe ||= Minarai::Loaders::RecipeLoader.new(recipe_path, variable_path: variable_path).load
    end

    def recipe_path
      slop_options.arguments[0] or raise Minarai::Errors::MissingRecipePathError
    end

    def variable_path
      slop_options[:variables]
    end

    def slop_options
      @slop_options ||= Slop.parse(@args, suppress_errors: true) do |option|
        option.string '-v', '--variables', 'variable file for erb recipe file'
      end
    end
  end
end
