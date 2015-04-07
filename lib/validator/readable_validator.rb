require 'active_model'

class ReadableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if !value.nil? && !File.readable?(value)
      record.errors.add(attribute, 'is not exist or can\' be readable file.')
    end
  end
end
