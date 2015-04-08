require 'hashie/mash'

module Minarai
  class Variable
    def initialize(variable)
      @variable = variable
    end

    def to_mash
      MashedVariable.new(@variable)
    end

    class MashedVariable < Hashie::Mash
      def binding
        super
      end
    end
  end
end
