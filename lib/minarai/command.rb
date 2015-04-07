require 'slop'
require 'minarai/recipe_loader'

module Minarai
  class Command
    def initialize(args)
      @args = args
    end

    def call
      if recipe.valid?
        recipe.runner.run
      else
        puts recipe.errors.map(&:to_s)
      end
    end

    private

    def recipe
      @recipe ||= Minarai::RecipeLoader.new(recipe_path).load
    end

    def recipe_path
      slop_options['recipe'] || 'default.yml' # @TODO fix deafult path
    end

    def slop_options
      @slop_options ||= Slop.parse(@args, suppress_errors: true) do |option|
        option.string('-r', '--recipe', 'require recipe file')
      end
    end
  end
end
