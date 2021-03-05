# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../lib/rover'
require_relative '../../lib/plateau'
require_relative '../../main'

class TestMain < Minitest::Test
  def setup
    @execution_input = <<~HERE
      5 5
      1 2 N
      L M L M L M L M M
      3 3 E
      M M R M M R M R R M
    HERE
  end

  def test_it_accepts_instructions_input_and_calculates_final_rovers_position
    rover_results = Main.run(@execution_input)
    assert_equal 2, rover_results.size
    assert_equal ({ x: 1, y: 3 }), rover_results.first[:position]
    assert_equal 'N', rover_results.first[:direction]
    assert_equal ({ x: 5, y: 1 }), rover_results.last[:position]
    assert_equal 'E', rover_results.last[:direction]
  end
end
