require 'specinfra'

module Minarai
  class Runner
    def initialize(actions)
      @actions = actions
    end

    def run
      puts 'Start minarai...'
      @actions.each do |action|
        action.backend = backend
        action.call
      end
      puts 'minarai done...'
    end

    private

    def backend
      @backend ||= Specinfra::Backend::Exec.new
    end
  end
end
