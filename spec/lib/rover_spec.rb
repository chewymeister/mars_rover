require 'spec_helper'

describe Rover do
  boundaries = { upper_x: 10, upper_y: 10 }
  let(:test_rover) { Rover.new(boundaries) }

  context 'turning left' do

    it 'should be facing west' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'L' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '0 0 W'
    end

    it 'should be facing east' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'LLL' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '0 0 E'
    end

    it 'should be facing south' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'LLLLLL' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '0 0 S'
    end
  end

  context 'turning right' do
    it 'should be facing east' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'R' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '0 0 E'
    end

    it 'should be facing west' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'RRR' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '0 0 W'
    end

    it 'should be facing south' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'RRRRRRRRRR' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '0 0 S'
    end
  end

  context 'moving forward' do
    it 'should have moved north by one' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'M' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '0 1 N'
    end

    it 'should have moved east by one' do
      instructions = { coords: { x: 0, y: 0, cardinal: 'E' }, commands: 'MM' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '2 0 E'
    end

    it 'should have moved south by one' do
      instructions = { coords: { x: 5, y: 5, cardinal: 'S' }, commands: 'MMM' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '5 2 S'
    end
  end

  context 'can take multiple commands' do
    it 'simple commands' do
      command = 'LRLMMLM'
      instructions = { coords: { x: 4, y: 4, cardinal: 'N' }, commands: 'LRLMMLM' }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '2 3 S'
    end

    it 'commands that lead the rover to the edge' do
      command = 'LRLMMMMMMMMMMMLMMMMMMMMMRMMLLMMMLMMR'
      instructions = { coords: { x: 4, y: 4, cardinal: 'N' }, commands: command }
      test_rover.move_using(instructions)

      expect(test_rover.current_location).to eq '3 2 E'
    end
  end
end
