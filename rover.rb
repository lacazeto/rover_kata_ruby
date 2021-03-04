# frozen_string_literal: true

# Class to represent a Rover
class Rover
  attr_reader :position, :direction

  @@accepted_commands = %w[L R M]
  @@accepted_cardinal_directions = %w[S N E W]
  @@rotation = {
    'L' => {
      'N' => 'W',
      'W' => 'S',
      'S' => 'E',
      'E' => 'N'
    },
    'R' => {
      'N' => 'E',
      'E' => 'S',
      'S' => 'W',
      'W' => 'N'
    }
  }

  def initialize(position:, direction:)
    @position = { x: position[:x], y: position[:y] }
    @direction = direction
  end

  def rotate(value)
    Rover.validate_command(value)
    @direction = @@rotation[value][@direction]
  end

  def self.validate_command(command)
    raise ArgumentError, "Invalid command #{command}" unless @@accepted_commands.include?(command.upcase)
  end

  def self.validate_cardinal_direction(direction)
    raise ArgumentError, "Invalid cardinal direction #{direction}" unless
      @@accepted_cardinal_directions.include?(direction.upcase)
  end
end
