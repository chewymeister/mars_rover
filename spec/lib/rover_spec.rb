require 'rspec'
require './lib/rover'

describe Rover do
  it 'can move left' do
    test_rover = Rover.new
    test_rover.move('0 0 N', 'L')

    expect(test_rover.current_location).to eq '0 0 W'
  end

  it 'can move right' do
    test_rover = Rover.new
    test_rover.move('0 0 N', 'R')

    expect(test_rover.current_location).to eq '0 0 E'
  end
end
