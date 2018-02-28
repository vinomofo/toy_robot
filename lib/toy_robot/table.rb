require 'matrix'

module ToyRobot
  class Table
    DIRECTIONS = {
      'NORTH' => Vector[1, 0],
      'EAST' => Vector[0, 1],
      'SOUTH' => Vector[-1, 0],
      'WEST' => Vector[0, -1]
    }.freeze

    def initialize(height:, width:)
      @height = height
      @width = width
    end

    def valid_position?(north, east)
      (0...height).cover?(north) && (0...width).cover?(east)
    end

    def valid_direction?(direction)
      DIRECTIONS.key?(direction)
    end

    def next_position(north, east, direction)
      position = Vector.elements([north, east]) + get_direction(direction)

      position.to_a
    end

    private

    attr_reader :width, :height

    def get_direction(dir)
      DIRECTIONS[dir]
    end
  end
end
