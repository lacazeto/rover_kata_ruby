# frozen_string_literal: true

# Class to represent a Rover
class Rover
  @accepted_commands = %w[L R M]
  @accepted_cardinal_directions = %w[S N E W]

  def initialize(position:, direction:)
    @position = { x: position.x, y: position.y }
    @direction = direction
  end

  def self.validate_command(command)
    raise ArgumentError, "Invalid command #{command}" unless @accepted_commands.include?(command.upcase)

    nil
  end

  def self.validate_cardinal_direction(direction)
    raise ArgumentError, "Invalid cardinal direction #{direction}" unless
      @accepted_cardinal_directions.include?(direction.upcase)

    nil
  end
end
