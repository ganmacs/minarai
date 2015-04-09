require 'logger'
require 'ansi/code'

module Minarai
  class Logger
    class Formatter
      def call(severity, _datetime, _progname, msg)
        @severity = severity
        colorize "%{severity} : %{msg}\n" % {
          severity: severity,
          msg: msg
        }
      end

      private

      def colorize(log)
        ANSI.public_send(color) { log }
      end

      def color
        case @severity
        when 'INFO'
          :green
        when 'WARN'
          :magenta
        when 'ERROR', 'FATAL'
          :red
        end
      end
    end

    class << self
      METHODS = %i(warn info error fatal)

      METHODS.each do |method_name|
        define_method(method_name) do |msg|
          if msg.is_a?(Array)
            msg.each do |m|
              logger.public_send(method_name, m)
            end
          else
            logger.public_send(method_name, msg)
          end
        end
      end
      alias_method :skip, :info
      alias_method :done, :info
      alias_method :fail, :error

      def logger
        @logger ||= create_logger
      end
      alias_method :new, :logger

      private

      def logger_device
        @logger_device || STDOUT
      end

      def create_logger
        ::Logger.new(logger_device).tap do |logger|
          logger.formatter = Formatter.new
        end
      end
    end
  end
end
