# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../helpers/integer_parser'

class IntegerParserTest < Minitest::Spec
  def test_valid_inputs_as_positive_integers
    expect { IntegerParser.validate_positive_integer('b', '5') }.must_raise ArgumentError
    expect { IntegerParser.validate_positive_integer('10', '-1') }.must_raise ArgumentError
    assert_nil IntegerParser.validate_positive_integer('10', '1')
    assert_nil IntegerParser.validate_positive_integer('0', '0')
    assert_nil IntegerParser.validate_positive_integer('2', '5')
  end

  def test_validator_accepts_any_number_of_arguments
    assert_nil IntegerParser.validate_positive_integer('10')
    assert_nil IntegerParser.validate_positive_integer('10', '1', '0', '4')
  end

  def test_validator_can_handle_both_integers_and_text
    assert_nil IntegerParser.validate_positive_integer(1)
    assert_nil IntegerParser.validate_positive_integer('1')
  end

  def test_validator_accepts_customised_error_message
    err = expect { IntegerParser.validate_positive_integer('b', '5', error_message: 'This is a custom message') }
          .must_raise ArgumentError
    expect(err.message).must_match(/This is a custom message/)
  end

  def test_validator_raises_default_error_message_if_none_is_passed
    err = expect { IntegerParser.validate_positive_integer('b', '5') }.must_raise ArgumentError
    expect(err.message).must_match(/Received invalid arguments. Expecting only positive integers/)
  end
end
