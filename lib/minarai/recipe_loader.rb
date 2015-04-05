require 'yaml'
require 'pathname'
require 'minarai/recipe'

module Minarai
  class RecipeLoader
    def initialize(path)
      @path = path
    end

    def load
      raise "Does not exist file: #{pathname}" unless valid_recipe_path?
      Minarai::Recipe.new(load_file_from_yaml)
    end

    def load_file_from_yaml
      YAML.load_file(pathname)
    end

    def valid_recipe_path?
      pathname.exist?
    end

    def pathname
      @pathname ||= Pathname.new(@path)
    end
  end
end
