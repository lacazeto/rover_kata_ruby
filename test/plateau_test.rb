# frozen_string_literal: true

require 'minitest/autorun'
require 'mocha/minitest'
require_relative '../lib/plateau'

class TestPlateau < Minitest::Spec
  def test_checks_passed_boundaries_are_valid
    err = expect { Plateau.validate_boundaries('b', '5') }.must_raise ArgumentError
    expect(err.message).must_match(/Invalid arguments for the upper-right coordinate. Expecting only positive integers/)

    err = expect { Plateau.validate_boundaries('10', '-1') }.must_raise ArgumentError
    expect(err.message).must_match(/Invalid arguments for the upper-right coordinate. Expecting only positive integers/)

    assert_nil Plateau.validate_boundaries('10', '1')
    assert_nil Plateau.validate_boundaries('0', '0')
  end

  def test_checks_rover_poistion_is_valid
    plateau = Plateau.new(5, 5) # 6x6 grid
    assert_nil plateau.validate_rover_position(2, 5)
    assert_nil plateau.validate_rover_position(3, 3)
    assert_nil plateau.validate_rover_position(6, 0)

    err = expect { plateau.validate_rover_position(7, 0) }.must_raise IndexError
    expect(err.message).must_match(/Rover position falls off plateau boundaries/)
  end

  def test_plateau_grid_was_correctly_generated
    plateau1 = Plateau.new('3', '2')
    assert_equal 3, plateau1.grid.size
    assert_equal 12, plateau1.grid.flatten.size

    plateau2 = Plateau.new('5', '5')
    assert_equal 6, plateau2.grid.size
    assert_equal 36, plateau2.grid.flatten.size
  end

  def test_keeps_track_of_deployed_rovers
    plateau = Plateau.new('5', '5')
    assert_equal 0, plateau.rovers.size

    plateau.add_rover('1', '2', 'N')
    assert_equal 1, plateau.rovers.size
    # (1, 2) in cartesian coordinates become (1, 3) in computer coordinates in a 5x5 grid.
    assert_equal ({ x: 1, y: 3 }), plateau.rovers[1].position
    assert_equal 1, plateau.grid[3][1]
  end

  def test_outputs_rover_position_in_cartesian_readable_format
    plateau = Plateau.new('3', '3')
    plateau.add_rover('1', '2', 'N')
    assert_equal ({ x: 1, y: 2 }), plateau.rovers_in_cartesian_plain.first[:position]
  end

  def test_calls_rover_to_update_its_direction
    plateau = Plateau.new('2', '2')
    plateau.add_rover('1', '2', 'N')
    Rover.any_instance.stubs(:rotate)
    Rover.any_instance.expects(:rotate).with('L').at_least_once
    plateau.move_rover('L', rover: 1)
  end

  def test_prevents_hover_from_moving_to_already_occupied_space
    plateau = Plateau.new('2', '2')
    plateau.add_rover('1', '1', 'N')

    assert_nil plateau.check_for_obstacles(1, 0)
    assert_nil plateau.check_for_obstacles(0, 1)

    err = expect { plateau.check_for_obstacles(1, 1) }.must_raise RuntimeError
    expect(err.message).must_match(/Rover cannot move to an already occupied block/)
  end
end
