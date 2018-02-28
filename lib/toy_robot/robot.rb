module ToyRobot
  class Robot
    def initialize(table = Table.new)
      @table = table
      @directions = Table::DIRECTIONS.keys
    end

    attr_reader :current_position

    def place(north, east, direction)
      raise PositionError if !table.valid_position?(north, east) || !table.valid_direction?(direction)

      @current_position = [north, east]

      rotate until current_direction == direction
    end

    def move
      raise PlacementError unless placed?

      next_position = table.next_position(*current_position, current_direction)

      raise PositionError unless table.valid_position?(*next_position)

      @current_position = next_position
    end

    def right
      raise PlacementError unless placed?

      rotate
    end

    def left
      raise PlacementError unless placed?

      rotate(false)
    end

    def report
      raise PlacementError unless placed?

      { north: current_position[0], east: current_position[1], direction: current_direction }
    end

    def current_position
      @current_position
    end

    def current_direction
      directions.first
    end

    private

    attr_reader :table, :directions

    def rotate(clockwise = true)
      directions.rotate!(clockwise ? 1 : -1)
    end

    def placed?
      !@current_position.nil?
    end
  end
end
