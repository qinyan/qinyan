# config/initializers/email_validator.rb
class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attr_name, value)
    unless value =~ /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
      record.errors.add(attr_name, :email_format, options.merge(:value => value))
    end
  end
end


