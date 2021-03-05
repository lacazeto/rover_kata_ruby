# frozen_string_literal: true

require_relative 'lib/plateau'
require_relative 'lib/rover'

raise 'No instructions file provided' unless ARGV[0]

execution_input = File.read(ARGV[0])

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

plateau.rovers.each do |rover_details|
  rover = rover_details.keys[0]
  print("#{rover} final location is (#{rover_details[rover][:position][:x]}, #{rover_details[rover][:position][:y]}) "\
        "pointing to #{rover_details[rover][:direction]}\n")
end
