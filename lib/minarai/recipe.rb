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

    def valid?
      errors.empty?
    end

    def errors
      @errors ||= actions.flat_map(&:error_messages).map(&:to_s)
    end
  end
end
