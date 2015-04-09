require 'minarai/actions/base'

module Minarai
  module Actions
    class Directory < Base
      attribute :destination, required: true, type: String
      attribute :owner, type: String
      attribute :group, type: String

      def run
        create
        change_group unless has_valid_group?
        change_owner unless has_valid_owner?
      end

      private

      def create
        # puts 'create'
        run_specific_command(:create_file_as_directory, destination)
      end

      def complete?
        existed_file?
      end

      def existed_file?
        check_specific_command(:check_file_is_directory, destination)
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

      def name
        super || "create #{destination} directory"
      end
    end
  end
end
