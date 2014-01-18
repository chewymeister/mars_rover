require 'spec_helper'

describe Rover do
  boundaries = { upper_x: 10, upper_y: 10 }
  let(:test_rover) { Rover.new(boundaries) }

  context 'turning left' do
    it 'should be facing west' do
      test_rover.move('0 0 N', 'L')

      expect(test_rover.current_location).to eq '0 0 W'
    end

    it 'should be facing east' do
      test_rover.move('0 0 N', 'LLL')

      expect(test_rover.current_location).to eq '0 0 E'
    end

    it 'should be facing south' do
      test_rover.move('0 0 N', 'LLLLLL')

      expect(test_rover.current_location).to eq '0 0 S'
    end
  end

  context 'turning right' do
    it 'should be facing east' do
      test_rover.move('0 0 N', 'R')

      expect(test_rover.current_location).to eq '0 0 E'
    end

    it 'should be facing west' do
      test_rover.move('0 0 N', 'RRR')

      expect(test_rover.current_location).to eq '0 0 W'
    end

    it 'should be facing south' do
      test_rover.move('0 0 N', 'RRRRRRRRRR')

      expect(test_rover.current_location).to eq '0 0 S'
    end
  end

  context 'moving forward' do
    it 'should have moved north by one' do
      test_rover.move('0 0 N', 'M')

      expect(test_rover.current_location).to eq '0 1 N'
    end

    it 'should have moved east by one' do
      test_rover.move('0 0 E', 'MM')

      expect(test_rover.current_location).to eq '2 0 E'
    end

    it 'should have moved south by one' do
      test_rover.move('5 5 S', 'MMM')

      expect(test_rover.current_location).to eq '5 2 S'
    end
  end

  context 'can take multiple commands' do
    it 'simple commands' do
      command = 'LRLMMLM'
      test_rover.move('4 4 N', command)

      expect(test_rover.current_location).to eq '2 3 S'
    end

    it 'commands that lead the rover to the edge' do
      command = 'LRLMMMMMMMMMMMLMMMMMMMMMRMMLLMMMLMMR'
      test_rover.move('4 4 N', command)

      expect(test_rover.current_location).to eq '3 2 E'
    end
  end
end
