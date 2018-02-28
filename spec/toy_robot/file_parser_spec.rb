require 'spec_helper'
require_relative '../../lib/toy_robot/file_parser'

RSpec.describe ToyRobot::FileParser do
  let(:stubbed_command_parser) { instance_double(ToyRobot::CommandParser, call: true) }
  subject { ToyRobot::FileParser.new(stubbed_command_parser, 'test_file.txt') }

  before do
    allow(File).to receive(:read).and_return("1\n2\n3\n4\n")
  end

  describe '#call' do
    it 'passes commands from the file specified to the command parser' do
      expect(stubbed_command_parser).to receive(:call).with('1')
      expect(stubbed_command_parser).to receive(:call).with('2')
      expect(stubbed_command_parser).to receive(:call).with('3')
      expect(stubbed_command_parser).to receive(:call).with('4')

      subject.call
    end
  end
end
