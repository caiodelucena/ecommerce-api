class FutureDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    message = options[:message] || :future_date

    record.errors.add(attribute, message) if value <= DateTime.current
  end
end
