# frozen_string_literal: true

# Class to represent a Rover
class Rover
  @accepted_commands = %w[L R M]
  @accepted_cardinal_directions = %w[S N E W]

  def initialize(position:, direction:)
    @position = { x: position.x, y: position.y }
    @direction = direction
  end

  def self.valid_command?(command)
    @accepted_commands.include?(command.upcase)
  end

  def self.valid_cardinal_direction?(direction)
    @accepted_cardinal_directions.include?(direction.upcase)
  end
end
