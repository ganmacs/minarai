require 'yaml'
require 'pathname'
require 'erb'

module Minarai
  module Loaders
    class Base
      def initialize(path)
        @path = path
      end

      def load
        case
        when !existed_file?
          raise "Does not exist file: #{pathname}"
        when yml_file?
          load_yaml_file
        when erb_file?
          load_erb_file
        else
          raise 'inalid extname error'
        end
      end

      private

      def binding_for_erb
        TOPLEVEL_BINDING
      end

      def loaded_class
        raise NotImplementedError
      end

      def load_yaml_file
        loaded_class.new(load_file_from_yaml)
      end

      def load_erb_file
        self.class.new(parsed_erb_file.path).load
      end

      def parsed_erb
        ERB.new(pathname.read).result(binding_for_erb)
      end

      def parsed_erb_file
        @parsed_erb_file ||= Tempfile.open(['', '.yml']) do |tmp|
          tmp.puts parsed_erb
          tmp
        end
      end

      def existed_file?
        pathname.exist?
      end

      def yml_file?
        %w(.yml yaml).include?(pathname.extname)
      end

      def erb_file?
        pathname.extname == '.erb'
      end

      def load_file_from_yaml
        YAML.load_file(pathname)
      end

      def pathname
        @pathname ||= Pathname.new(@path)
      end
    end
  end
end
