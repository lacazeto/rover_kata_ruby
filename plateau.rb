# frozen_string_literal: true

require_relative 'rover'
require_relative 'helpers/integer_parser'

# Class to render the Plateau
class Plateau
  attr_reader :grid, :rovers

  def initialize(columns, rows)
    Plateau.validate_boundaries(columns, rows)

    @grid = grid_setup(columns, rows)
    @rovers = {}
  end

  def add_hover(x, y, direction)
    validate_hover_position(x, y)
    Rover.validate_cardinal_direction(direction)
    deploy_hover(x, y, direction)
  end

  def validate_hover_position(x, y)
    IntegerParser.validate_positive_integer(x, y)
    zero_index_x = x.to_i + 1
    zero_index_y = y.to_i + 1

    raise ArgumentError, 'Hover position falls off plateau boundaries' if
      zero_index_x > @grid[0].size || zero_index_y > @grid.size
  end

  def self.validate_boundaries(x, y)
    error_message = 'Invalid arguments for the upper-right coordinate. Expecting only positive integers'
    IntegerParser.validate_positive_integer(x, y, error_message: error_message)
  end

  private

  def deploy_hover(x, y, direction)
    rover_number = @rovers.size + 1
    @rovers[rover_number] = Rover.new(position: { x: x, y: y }, direction: direction)
  end

  def grid_setup(x, y)
    grid = []
    zero_index_x = x.to_i + 1
    (0..y.to_i).each { grid.push(Array.new(zero_index_x)) }

    grid
  end
end
