require 'spec_helper'

describe Rover do
  boundaries = { upper_x: 10, upper_y: 10 }
  let(:test_rover) { Rover.new(boundaries) }

  it 'can turn left' do
    test_rover.move('0 0 N', 'L')

    expect(test_rover.current_location).to eq '0 0 W'
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
