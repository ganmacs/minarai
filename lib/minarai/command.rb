require 'slop'
require 'minarai/recipe_loader'

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
      @recipe ||= Minarai::RecipeLoader.new(recipe_path).load
    end

    def recipe_path
      slop_options['recipe']
    end

    def slop_options
      @slop_options ||= Slop.parse(@args, suppress_errors: true) do |option|
        option.string('-r', '--recipe', 'require recipe file')
      end
    end
  end
end
