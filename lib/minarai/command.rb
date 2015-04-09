require 'slop'
require 'minarai/loaders/recipe_loader'
require 'minarai/errors/missing_recipe_path_error.rb'
require 'minarai/logger'

module Minarai
  class Command
    def initialize(args)
      @args = args
    end

    def call
      Minarai::Logger.info 'Minarai starting...'
      abort_with_error_message unless recipe.valid?
      recipe.runner.run
      Minarai::Logger.info 'Minarai finish'
    end

    private

    def abort_with_error_message
      Minarai::Logger.error(recipe.errors) and abort
    end

    def recipe
      @recipe ||= Minarai::Loaders::RecipeLoader.new(recipe_path, variable_path: variable_path).load
    end

    def recipe_path
      slop_options.arguments[0] || (Minarai::Logger.error(recipe_missing_error) and abort)
    end

    def recipe_missing_error
      Minarai::Errors::MissingRecipePathError.new
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
