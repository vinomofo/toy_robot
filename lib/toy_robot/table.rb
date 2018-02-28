require 'matrix'

module ToyRobot
  class Table
    DIRECTIONS = {
      'NORTH' => Vector[1, 0],
      'EAST' => Vector[0, 1],
      'SOUTH' => Vector[-1, 0],
      'WEST' => Vector[0, -1]
    }.freeze

    def initialize(table_size = 5)
      @table_size = table_size
    end

    def valid_position?(north, east)
      position = Vector.elements([north, east])

      position.max < @table_size && position.min >= 0
    end

    def valid_direction?(direction)
      DIRECTIONS.key?(direction)
    end

    def next_position(north, east, direction)
      position = Vector.elements([north, east]) + get_direction(direction)

      position.to_a
    end

    private

    def get_direction(dir)
      DIRECTIONS[dir]
    end
  end
end
