# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/rover'

class TestPlateau < Minitest::Spec
  def test_valid_command_was_passed
    assert_nil Rover.validate_command('L')
    assert_nil Rover.validate_command('R')
    assert_nil Rover.validate_command('M')
    err = expect { Rover.validate_command('G') }.must_raise ArgumentError
    expect(err.message).must_match(/Invalid command/)
  end

  def test_valid_commands_are_case_insensitive
    assert_nil Rover.validate_command('L')
    assert_nil Rover.validate_command('l')
  end

  def test_valid_direction_was_passed
    assert_nil Rover.validate_cardinal_direction('N')
    assert_nil Rover.validate_cardinal_direction('S')
    assert_nil Rover.validate_cardinal_direction('E')
    assert_nil Rover.validate_cardinal_direction('W')
    err = expect { Rover.validate_cardinal_direction('C') }.must_raise ArgumentError
    expect(err.message).must_match(/Invalid cardinal direction/)
  end

  def test_valid_directions_are_case_insensitive
    assert_nil Rover.validate_cardinal_direction('N')
    assert_nil Rover.validate_cardinal_direction('n')
  end

  def test_updates_direction_on_every_rotation
    rover = Rover.new(position: { x: 1, y: 1 }, direction: 'N')
    rover.rotate('L')
    assert_equal 'W', rover.direction

    rover = Rover.new(position: { x: 1, y: 1 }, direction: 'E')
    rover.rotate('R')
    assert_equal 'S', rover.direction
  end
end
