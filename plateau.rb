# frozen_string_literal: true

require_relative 'rover'
require_relative 'helpers/integer_parser'

# Class to represent the Plateau
class Plateau
  attr_reader :grid, :rovers

  def initialize(columns, rows)
    Plateau.validate_boundaries(columns, rows)

    @grid = grid_setup(columns, rows)
    @rovers = {}
  end

  def add_rover(x, y, direction)
    validate_rover_position(x, y)
    Rover.validate_cardinal_direction(direction)
    deploy_rover(x.to_i, y.to_i, direction)
  end

  def move_rover(*commands, rover:)
    commands.each do |value|
      case value
      when 'M'
        # new_position = 'bla'
        # validate_rover_position(new_position)
        # Update the rover
      else
        @rovers[rover].rotate(value)
      end
    end
  end

  def validate_rover_position(x, y)
    IntegerParser.validate_positive_integer(x, y)
    zero_index_x = x.to_i + 1
    zero_index_y = y.to_i + 1

    raise ArgumentError, 'rover position falls off plateau boundaries' if
      zero_index_x > @grid[0].size || zero_index_y > @grid.size
  end

  def self.validate_boundaries(x, y)
    error_message = 'Invalid arguments for the upper-right coordinate. Expecting only positive integers'
    IntegerParser.validate_positive_integer(x, y, error_message: error_message)
  end

  private

  def deploy_rover(x, y, direction)
    rover_number = @rovers.size + 1
    @rovers[rover_number] = Rover.new(position: { x: x, y: y }, direction: direction)
    @grid[catersian_vertical_axis(y)][x] = rover_number
  end

  def catersian_vertical_axis(y)
    @grid.size - y - 1
  end

  def grid_setup(x, y)
    grid = []
    zero_index_x = x.to_i + 1
    (0..y.to_i).each { grid.push(Array.new(zero_index_x)) }

    grid
  end
end
