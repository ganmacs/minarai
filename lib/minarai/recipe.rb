require 'minarai/action_builder'

module Minarai
  class Recipe
    def initialize(loaded_data)
      @loaded_data = loaded_data
    end

    def resouces
      @resouces ||= @loaded_data.map do |d|
        Minarai::ActionBuilder.new(d).build
      end
    end
  end
end
