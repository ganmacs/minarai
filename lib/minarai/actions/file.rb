require 'minarai/actions/base'

module Minarai
  module Actions
    class File < Base
      attribute :destination, required: true, type: String
      attribute :source, required: true, type: String, readable: true
      attribute :owner, type: String
      attribute :group, type: String
      attribute :state, type: String, default: ''

      def run
        copy
        change_group unless has_valid_group?
        change_owner unless has_valid_owner?
      end

      private

      def copy
        puts 'copy'
        # run_specific_command(:copy_file, source, destination)
      end

      def complete?
        existed_file? && same_content?
      end

      def existed_file?
        check_specific_command(:check_file_is_file, destination)
      end

      def same_content?
        sha256_content(destination) == sha256_content(source)
      end

      def sha256_content(path)
        run_specific_command(:get_file_sha256sum, path).stdout.rstrip
      end

      def has_valid_group?
        group.nil? || check_specific_command(:check_file_is_grouped, destination, group)
      end

      def has_valid_owner?
        owner.nil? || check_specific_command(:check_file_is_owned_by, destination, owner)
      end

      def change_group
        run_specific_command(:change_file_group, destination, group)
      end

      def change_owner
        run_specific_command(:change_file_owner, destination, owner)
      end

      def has_source?
        !source.nil?
      end

      def name
        super || "copy #{repository} to #{destination}"
      end
    end
  end
end
