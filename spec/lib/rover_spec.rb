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

  it 'can move right' do
    test_rover.move('0 0 N', 'R')

    expect(test_rover.current_location).to eq '0 0 E'
  end

  it 'can move forward' do
    test_rover.move('0 0 N', 'F')

    expect(test_rover.current_location).to eq '0 1 N'
  end

  it 'can take multiple commands' do
    command = 'LRLFFLF'
    test_rover.move('4 4 N', command)

    expect(test_rover.current_location).to eq '2 3 S'
  end
end
