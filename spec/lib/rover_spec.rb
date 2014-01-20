require 'spec_helper'

describe Rover do
  let(:boundaries) { { upper_x: 10, upper_y: 10 } }

  context 'turning left' do

    it 'should be facing west with one left turn, output "0 0 W"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'L' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '0 0 W'
    end

    it 'should be facing east with three left turns, output "0 0 E"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'LLL' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '0 0 E'
    end

    it 'should be facing south with six left turns, output "0 0 S"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'LLLLLL' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '0 0 S'
    end
  end

  context 'turning right' do
    it 'should be facing east with one right turn, output "0 0 E"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'R' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '0 0 E'
    end

    it 'should be facing west with three right turns, output "0 0 W"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'RRR' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '0 0 W'
    end

    it 'should be facing south with ten right turns, output "0 0 S"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'RRRRRRRRRR' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '0 0 S'
    end
  end

  context 'moving forward' do
    it 'should have moved north by one, output "0 1 N"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'N' }, commands: 'M' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '0 1 N'
    end

    it 'should have moved east by one, output "2 0 E"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 0, y: 0, cardinal: 'E' }, commands: 'MM' }
      }
      instructions = { coords: { x: 0, y: 0, cardinal: 'E' }, commands: 'MM' }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '2 0 E'
    end

    it 'should have moved south by one, output "5 2 S"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 5, y: 5, cardinal: 'S' }, commands: 'MMM' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '5 2 S'
    end
  end

  context 'can take multiple commands' do
    it 'simple commands, output "2 3 S"' do
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 4, y: 4, cardinal: 'N' }, commands: 'LRLMMLM' }
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '2 3 S'
    end

    it 'commands that lead the rover to the edge, output "3 2 E"' do
      command = 'LRLMMMMMMMMMMMLMMMMMMMMMRMMLLMMMLMMR'
      input = { 
        boundaries: boundaries,
        instructions: { coords: { x: 4, y: 4, cardinal: 'N' }, commands: command}
      }
      test_rover = Rover.new(input)

      expect(test_rover.current_location).to eq '3 2 E'
    end
  end
end
