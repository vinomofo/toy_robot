module ToyRobot
  class CommandParser
    def initialize(robot = ToyRobot::Robot.new)
      @robot = robot
    end

    def call(input)
      cmd, _sep, args = input.strip.partition(' ')

      case cmd
      when /PLACE/ then place_robot(args)
      when /MOVE/ then move_robot
      when /RIGHT/ then turn_robot_right
      when /LEFT/ then turn_robot_left
      when /REPORT/ then report_position
      else raise CommandError, 'Invalid command'
      end
    end

    private

    attr_reader :robot

    def place_robot(args)
      north, east, direction = args.split(',')

      robot.place(Integer(north), Integer(east), direction)
    rescue ArgumentError
      raise CommandError, 'Invalid arguments'
    end

    def move_robot
      robot.move
    end

    def turn_robot_right
      robot.right
    end

    def turn_robot_left
      robot.left
    end

    def report_position
      current_position = robot.report
      puts "Robot is currently at (#{current_position[:north]}, #{current_position[:east]}) and it's facing #{current_position[:direction]}"
    end
  end
end
