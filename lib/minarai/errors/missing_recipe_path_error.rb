require 'minarai/errors/base'

module Minarai
  module Errors
    class MissingRecipePathError  < Base
      def to_s
        'file path of recipe is required'
      end
    end
  end
end
