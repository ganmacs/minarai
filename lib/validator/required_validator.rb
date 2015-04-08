require 'active_model'

class RequiredValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is required') if value.nil?
  end
end
