require 'slop'
require 'minarai/actions/git'
require 'minarai/recipe_loader'

module Minarai
  class Command
    def initialize(args)
      @args = args
    end

    def call
      recipe.resouces.each do |resouce|
        resouce.call
      end
    end

    private

    def recipe
      @recipe ||= Minarai::RecipeLoader.new(recipe_path).load
    end

    def git
      Minarai::Actions::Git.new.call
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
