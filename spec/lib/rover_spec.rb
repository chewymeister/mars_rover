require 'rspec'
require './lib/rover'

describe Rover do
  let(:test_rover) { Rover.new }
  it 'can move left' do
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
end
