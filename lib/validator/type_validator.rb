require 'active_model'

class TypeValidator < ActiveModel::EachValidator
  def options
    super.merge(allow_nil: true)
  end

  def klasses
    options[:in] || [options[:with]]
  end

  def validate_each(record, attribute, value)
    unless klasses.any? { |klass| value.is_a?(klass) }
      record.errors.add(attribute, "must be a #{klasses}, not #{value.class}")
    end
  end
end
