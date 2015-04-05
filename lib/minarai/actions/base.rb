module Minarai
  module Actions
    class Base
      def initialize(attribute)
        @attribute = attribute
      end

      def call
        raise NotImplementedError
      end

      def name
        @attribute['name']
      end
    end
  end
end
