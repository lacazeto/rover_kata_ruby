# frozen_string_literal: true

require_relative 'rover'

# Class to render the Plateau
class Plateau
  attr_reader :grid, :rovers

  def initialize(columns, rows)
    @grid = grid_setup(columns, rows)
    @rovers = {}
  end

  # def update_rover_position(rover)
  #   raise ArgumentError, "Command #{command} is not a valid command."
  # end

  def add_hover(position:, direction:)
    rover_number = @rovers.size + 1
    @rovers[rover_number] = Rover.new(position, direction)
  end

  def self.validate_boundaries(columns, rows)
    columns_value = Integer(columns)
    rows_value = Integer(rows)
    raise ArgumentError if columns_value.abs != columns_value || rows_value.abs != rows_value
  rescue ArgumentError
    raise ArgumentError, 'Invalid arguments for the upper-right coordinate. Expecting only positive integers'
  end

  private

  def grid_setup(columns, rows)
    grid = []
    zero_index_columns = columns + 1
    (0..rows).each { grid.push(Array.new(zero_index_columns)) }

    grid
  end
end
