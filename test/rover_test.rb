# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../rover'

class TestPlateau < Minitest::Test
  def test_valid_command_was_passed
    assert_equal true, Rover.valid_command?('L')
    assert_equal true, Rover.valid_command?('R')
    assert_equal true, Rover.valid_command?('M')
    assert_equal false, Rover.valid_command?('G')
    assert_equal false, Rover.valid_command?('B')
  end

  def test_valid_commands_are_case_insensitive
    assert_equal true, Rover.valid_command?('L')
    assert_equal true, Rover.valid_command?('l')
  end

  def test_valid_direction_was_passed
    assert_equal true, Rover.valid_cardinal_direction?('N')
    assert_equal true, Rover.valid_cardinal_direction?('S')
    assert_equal true, Rover.valid_cardinal_direction?('E')
    assert_equal true, Rover.valid_cardinal_direction?('W')
    assert_equal false, Rover.valid_cardinal_direction?('C')
    assert_equal false, Rover.valid_cardinal_direction?('Z')
  end

  def test_valid_directions_are_case_insensitive
    assert_equal true, Rover.valid_cardinal_direction?('N')
    assert_equal true, Rover.valid_cardinal_direction?('n')
  end
end
