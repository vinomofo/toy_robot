require 'spec_helper'

RSpec.describe ToyRobot::Table do
  subject { ToyRobot::Table.new(width: 5, height: 5) }

  describe '#valid_position?' do
    it 'returns true when given a position that is on the table' do
      expect(subject.valid_position?(1, 2)).to be true
    end

    it 'returns false when given a position that is not on the table' do
      expect(subject.valid_position?(6, 2)).to be false
    end
  end

  describe '#valid_direction?' do
    it 'returns true when given a direction that is valid' do
      ['NORTH', 'SOUTH', 'EAST', 'WEST'].each do |direction|
        expect(subject.valid_direction?(direction)).to be true
      end
    end

    it 'returns false when given a direction that is not valid' do
      expect(subject.valid_direction?('UP')).to be false
    end
  end

  describe '#next_position' do
    context 'when asked to go NORTH' do
      let(:direction) { 'NORTH' }

      it 'returns a position that is 1 further than the given position' do
        north = 0
        east = 0

        expected_result = [1, 0]

        expect(subject.next_position(north, east, direction)).to eq expected_result
      end
    end

    context 'when asked to go SOUTH' do
      let(:direction) { 'SOUTH' }

      it 'returns a position that is 1 further than the given position' do
        north = 2
        east = 2

        expected_result = [1, 2]

        expect(subject.next_position(north, east, direction)).to eq expected_result
      end
    end

    context 'when asked to go EAST' do
      let(:direction) { 'EAST' }

      it 'returns a position that is 1 further than the given position' do
        north = 0
        east = 0

        expected_result = [0, 1]

        expect(subject.next_position(north, east, direction)).to eq expected_result
      end
    end

    context 'when asked to go WEST' do
      let(:direction) { 'WEST' }

      it 'returns a position that is 1 further than the given position' do
        north = 2
        east = 2

        expected_result = [2, 1]

        expect(subject.next_position(north, east, direction)).to eq expected_result
      end
    end

    context 'when asked to go further than the edge of the table' do
      it 'will return a value higher than the max' do
        north = 0
        east = 5

        expected_result = [0, 6]

        expect(subject.next_position(north, east, 'EAST')).to eq expected_result
      end

      it 'will return a value lower than 0' do
        north = 0
        east = 0

        expected_result = [0, -1]

        expect(subject.next_position(north, east, 'WEST')).to eq expected_result
      end
    end
  end
end
