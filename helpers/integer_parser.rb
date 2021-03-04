# frozen_string_literal: true

# Helper to parse integers
module IntegerParser
  def self.validate_positive_integer(*args, error_message: 'Received invalid arguments. Expecting only positive integers')
    args.each do |arg|
      arg_as_integer = Integer(arg)
      raise ArgumentError if arg_as_integer.abs != arg_as_integer
    rescue ArgumentError
      raise ArgumentError, error_message
    end
    nil
  end
end
