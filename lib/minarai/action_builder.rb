require 'active_support/core_ext/string/inflections'
require 'minarai/actions/git'
require 'minarai/actions/file'
require 'minarai/actions/homebrew'
require 'minarai/actions/homebrew_cask'
require 'minarai/actions/link'
require 'minarai/actions/unknown'
require 'minarai/actions/directory'
require 'minarai/actions/url_get'
require 'minarai/actions/rbenv'

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
        Minarai::Actions::Unknown
      end
    end

    def known_action_type?
      has_type? && Minarai::Actions.constants.include?(action_class_name.to_sym)
    end

    def action_class_name
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
