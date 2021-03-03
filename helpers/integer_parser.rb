# frozen_string_literal: true

# Helper to parse integers
module IntegerParser
  def self.validate_positive_integer(*args)
    args.each do |arg|
      arg_as_integer = Integer(arg)
      raise ArgumentError if arg_as_integer.abs != arg_as_integer
    end
    nil
  end
end
