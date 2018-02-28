require 'spec_helper'

RSpec.describe ToyRobot::CommandParser do
  let(:stubbed_robot) { instance_double(ToyRobot::Robot) }
  subject { ToyRobot::CommandParser.new(stubbed_robot) }

  describe '#call' do
    context "when given the 'PLACE' command" do
      it 'instructs the robot to be placed in the specified position' do
        expect(stubbed_robot).to receive(:place).with(0, 1, 'SOUTH')

        subject.call('PLACE 0,1,SOUTH')
      end
    end

    context "when given the 'MOVE' command" do
      it 'instructs the robot to move' do
        expect(stubbed_robot).to receive(:move)

        subject.call('MOVE')
      end
    end

    context "when given the 'RIGHT' command" do
      it 'instructs the robot to turn right' do
        expect(stubbed_robot).to receive(:right)

        subject.call('RIGHT')
      end
    end

    context "when given the 'LEFT' command" do
      it 'instructs the robot to turn left' do
        expect(stubbed_robot).to receive(:left)

        subject.call('LEFT')
      end
    end

    context "when given the 'REPORT' command" do
      it 'outputs a string describing the current position and direction' do
        allow(stubbed_robot).to receive(:report).and_return({ north: 1, east: 2, direction: 'NORTH' })

        expected_output = "Robot is currently at (1, 2) and it's facing NORTH"
        expect(STDOUT).to receive(:puts).with expected_output

        subject.call("REPORT")
      end
    end

    context 'when given an invalid command' do
      it 'raises an exception' do
        expect { subject.call('BING') }.to raise_error(ToyRobot::CommandError)
      end
    end
  end
end
