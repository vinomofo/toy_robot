require 'spec_helper'

RSpec.describe ToyRobot::Robot do
  let(:stubbed_table) { instance_double(ToyRobot::Table, valid_position?: true, valid_direction?: true) }
  subject { ToyRobot::Robot.new(stubbed_table) }

  describe '#place' do
    context 'when given valid position and direction arguments' do
      before do
        subject.place(0, 0, 'NORTH')
      end

      it 'changes the current position to one returned by the ToyRobot::Table' do
        expect(subject.current_position).to eq [0, 0]
      end

      it 'changes the current direction to the given direction' do
        expect(subject.current_direction).to eq 'NORTH'
      end
    end

    context 'when given an invalid position argument' do
      before do
        allow(stubbed_table).to receive(:valid_position?).and_return(false)
      end

      it 'raises an exception' do
        expect { subject.place(6, 0, 'NORTH') }.to raise_error(ToyRobot::PositionError)
      end
    end

    context 'when given an invalid direction argument' do
      before do
        allow(stubbed_table).to receive(:valid_direction?).and_return(false)
      end

      it 'raises an exception' do
        expect { subject.place(0, 0, 'DOWN') }.to raise_error(ToyRobot::PositionError)
      end
    end
  end

  describe '#move' do
    context 'when the robot has already been placed and is facing NORTH' do
      before do
        allow(stubbed_table).to receive(:next_position).and_return [1, 0]

        subject.place(0, 0, 'NORTH')
      end

      it 'changes the current position to the next position on the table' do
        subject.move

        expect(subject.current_position).to eq [1, 0]
      end

      it 'raises an error when attempting to move off the table' do
        allow(stubbed_table).to receive(:valid_position?).and_return(false)

        expect { subject.move }.to raise_error(ToyRobot::PositionError)
      end
    end

    context 'before the robot has been placed' do
      it 'does not change the current position' do
        expect { subject.move rescue nil }.not_to change { subject.current_position }
      end

      it 'raises an error' do
        expect { subject.move }.to raise_error(ToyRobot::PlacementError)
      end
    end
  end

  describe '#right' do
    context 'when the robot has already been placed and is pointing NORTH' do
      before do
        subject.place(0, 0, 'NORTH')
      end

      it 'rotates the current direction to EAST' do
        subject.right

        expect(subject.current_direction).to eq 'EAST'
      end
    end

    context 'when the robot has already been placed and is pointing EAST' do
      before do
        subject.place(0, 0, 'EAST')
      end

      it 'rotates the current direction to SOUTH' do
        subject.right

        expect(subject.current_direction).to eq 'SOUTH'
      end
    end

    context 'when the robot has already been placed and is pointing SOUTH' do
      before do
        subject.place(0, 0, 'SOUTH')
      end

      it 'rotates the current direction to WEST' do
        subject.right

        expect(subject.current_direction).to eq 'WEST'
      end
    end

    context 'when the robot has already been placed and is pointing WEST' do
      before do
        subject.place(0, 0, 'WEST')
      end

      it 'rotates the current direction to NORTH' do
        subject.right

        expect(subject.current_direction).to eq 'NORTH'
      end
    end

    context 'before the robot has been placed' do
      it 'does not change the current direction' do
        expect { subject.right rescue nil }.not_to change { subject.current_direction }
      end

      it 'raises an error' do
        expect { subject.right }.to raise_error(ToyRobot::PlacementError)
      end
    end
  end

  describe '#left' do
    context 'when the robot has already been placed and is pointing NORTH' do
      before do
        subject.place(0, 0, 'NORTH')
      end

      it 'rotates the current direction to WEST' do
        subject.left

        expect(subject.current_direction).to eq 'WEST'
      end
    end

    context 'when the robot has already been placed and is pointing EAST' do
      before do
        subject.place(0, 0, 'EAST')
      end

      it 'rotates the current direction to NORTH' do
        subject.left

        expect(subject.current_direction).to eq 'NORTH'
      end
    end

    context 'when the robot has already been placed and is pointing SOUTH' do
      before do
        subject.place(0, 0, 'SOUTH')
      end

      it 'rotates the current direction to EAST' do
        subject.left

        expect(subject.current_direction).to eq 'EAST'
      end
    end

    context 'when the robot has already been placed and is pointing WEST' do
      before do
        subject.place(0, 0, 'WEST')
      end

      it 'rotates the current direction to SOUTH' do
        subject.left

        expect(subject.current_direction).to eq 'SOUTH'
      end
    end

    context 'before the robot has been placed' do
      it 'does not change the current direction' do
        expect { subject.left rescue nil }.not_to change { subject.current_direction }
      end

      it 'raises an error' do
        expect { subject.left }.to raise_error(ToyRobot::PlacementError)
      end
    end
  end

  describe '#report' do
    context 'when the robot has already been placed and is pointing WEST' do
      before do
        subject.place(1, 2, 'WEST')
      end

      it 'reports the current position and direction' do
        expect(subject.report).to eq({ north: 1, east: 2, direction: 'WEST' })
      end
    end

    context 'before the robot has been placed' do
      it 'raises an error' do
        expect { subject.report }.to raise_error(ToyRobot::PlacementError)
      end
    end
  end
end
