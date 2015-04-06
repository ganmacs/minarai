require 'minarai/action_builder'
require 'minarai/runner'

module Minarai
  class Recipe
    def initialize(loaded_data)
      @loaded_data = loaded_data
    end

    def actions
      @actions ||= @loaded_data.map do |d|
        Minarai::ActionBuilder.new(d).build
      end
    end

    def runner
      @runner ||= Minarai::Runner.new(actions)
    end
  end
end
