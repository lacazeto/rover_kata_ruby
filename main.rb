# frozen_string_literal: true

require_relative 'plateau'
require_relative 'rover'

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

rover_instructions.each_slice(2) do |position, commands|
  plateau.add_hover(*position.split)
end
