module ToyRobot
  class FileParser
    def initialize(command_parser, filename)
      @command_parser = command_parser
      @filename = filename
    end

    def call
      commands = read_commands

      commands.each(&method(:execute_command))
    end

    private

    attr_reader :filename, :command_parser

    def read_commands
      File.read(filename).split("\n")
    end

    def execute_command(cmd)
      command_parser.call(cmd)
    rescue ToyRobot::PlacementError, ToyRobot::PositionError, ToyRobot::CommandError
    end
  end
end
