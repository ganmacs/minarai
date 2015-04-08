require 'minarai/errors/base'

module Minarai
  module Errors
    class MissingRecipePathError  < Base
      def to_s
        'recipe is required.'
      end
    end
  end
end
