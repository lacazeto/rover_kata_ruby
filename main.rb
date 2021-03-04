# frozen_string_literal: true

require_relative 'lib/plateau'
require_relative 'lib/rover'

execution_input = <<~HERE
  5 5
  1 2 N
  L M L M L M L M M
  3 3 E
  M M R M M R M R R M
HERE

grid_size, *rover_instructions = execution_input.split("\n")

grid_x, grid_y = grid_size.split
plateau = Plateau.new(grid_x, grid_y)

rover_instructions.each_slice(2).with_index do |(position, commands), index|
  plateau.add_rover(*position.split)
  plateau.move_rover(*commands.split, rover: index + 1)
end

puts plateau.rover_details
