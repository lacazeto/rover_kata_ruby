# frozen_string_literal: true

require_relative 'lib/plateau'
require_relative 'lib/rover'

# Namespaced main script
module Main
  def self.run(execution_input)
    grid_size, *rover_instructions = execution_input.split("\n")

    print('Grid size: ', grid_size, "\n\n")

    grid_x, grid_y = grid_size.split
    plateau = Plateau.new(grid_x, grid_y)

    rover_instructions.each_slice(2).with_index do |(position, commands), index|
      print("Rover_#{index + 1} landing position: ", position, "\n")
      print("Rover_#{index + 1} navigation commands: ", commands, "\n\n")

      plateau.add_rover(*position.split)
      plateau.move_rover(*commands.split, rover: index + 1)
    end

    plateau.rovers_in_cartesian_plain.each do |rover|
      print("Rover_#{rover[:id]} final location is (#{rover[:position][:x]}, #{rover[:position][:y]}) "\
            "pointing to #{rover[:direction]}\n")
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  raise 'No instructions file provided' unless ARGV[0]

  execution_file = File.read(ARGV[0])
  Main.run(execution_file)
end
