require 'active_support/core_ext/string/inflections'
require 'minarai/actions/git'

module Minarai
  class ActionBuilder
    def initialize(attirbutes)
      @attirbutes = attirbutes
    end

    def build
      action_class.new(@attirbutes)
    end

    private

    def action_class
      if known_action_type?
        Minarai::Actions.const_get(action_class_name, false)
      else
        # @TODO something error
        'error'
      end
    end

    def known_action_type?
      Minarai::Actions.constants.include?(action_class_name.to_sym)
    end

    def action_class_name
      raise 'type attirbute is required' unless has_type?
      type.camelize
    end

    def type
      @attirbutes['type']
    end

    def has_type?
      !!@attirbutes['type']
    end
  end
end
