# frozen_string_literal: true

require_relative 'rover'
require_relative '../helpers/integer_parser'

# Class to represent the Plateau
class Plateau
  attr_reader :rovers, :grid

  def initialize(columns, rows)
    Plateau.validate_boundaries(columns, rows)

    @grid = grid_setup(columns, rows)
    @rovers = {}
  end

  def add_rover(x, y, direction)
    validate_rover_landing_position(x, y)
    Rover.validate_cardinal_direction(direction)
    deploy_rover(x.to_i, y.to_i, direction)
  end

  def move_rover(*commands, rover:)
    commands.each do |value|
      case value
      when 'M'
        old_position, new_position = track_positions(rover)
        validate_rover_position(new_position[:x], new_position[:y])
        check_for_obstacles(new_position[:x], new_position[:y])
        @rovers[rover].update_position(new_position)
        grid_refresh(rover, old_position, new_position)
      else
        @rovers[rover].rotate(value)
      end
    end
  end

  def validate_rover_landing_position(x, y)
    IntegerParser.validate_positive_integer(x, y)
    zero_index_x = x.to_i + 1
    zero_index_y = y.to_i + 1

    validate_rover_position(zero_index_x, zero_index_y)
  end

  def validate_rover_position(x, y)
    raise IndexError, 'Rover position falls off plateau boundaries' if x > @grid[0]&.size || y > @grid&.size
  end

  def check_for_obstacles(x, y)
    raise 'Rover cannot move to an already occupied block' unless @grid[x][y]&.zero?
  end

  def self.validate_boundaries(x, y)
    error_message = 'Invalid arguments for the upper-right coordinate. Expecting only positive integers'
    IntegerParser.validate_positive_integer(x, y, error_message: error_message)
  end

  def track_positions(rover)
    old_position = @rovers[rover]&.position
    direction = @rovers[rover]&.direction
    case direction
    when 'N'
      new_position = { x: old_position[:x], y: old_position[:y] - 1 }
    when 'E'
      new_position = { x: old_position[:x] + 1, y: old_position[:y] }
    when 'S'
      new_position = { x: old_position[:x], y: old_position[:y] + 1 }
    when 'W'
      new_position = { x: old_position[:x] - 1, y: old_position[:y] }
    end

    [old_position, new_position]
  end

  def rovers_in_cartesian_plain
    @rovers.map do |key, rover|
      computer_coordinate = rover.position
      cartesian_coordinate = { x: computer_coordinate[:x], y: computer_cartesian_coordinate_translation(computer_coordinate[:y]) }
      { id: key, position: cartesian_coordinate, direction: rover.direction }
    end
  end

  private

  def deploy_rover(x, y, direction)
    rover_number = @rovers.size + 1
    cartesian_y = computer_cartesian_coordinate_translation(y)
    @rovers[rover_number] = Rover.new(position: { x: x, y: cartesian_y }, direction: direction)
    @grid[cartesian_y][x] = rover_number
  end

  def computer_cartesian_coordinate_translation(y)
    @grid.size - y - 1
  end

  def grid_setup(x, y)
    grid = []
    zero_index_x = x.to_i + 1
    (0..y.to_i).each { grid.push(Array.new(zero_index_x, 0)) }

    grid
  end

  def grid_refresh(rover, old_position, new_position)
    grid[old_position[:y]][old_position[:x]] = 0
    grid[new_position[:y]][new_position[:x]] = rover
  end
end
