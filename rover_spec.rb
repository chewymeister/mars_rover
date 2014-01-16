require 'rspec'
class Rover
  DIRECTIONS = ['N','E','S','W']

  def move(location, command)
    coords = location.split(' ')
    @x = coords[0].to_i
    @y = coords[1].to_i
    @facing = coords[2]
    @increment = determine_from(command)
    @facing = DIRECTIONS[calculate(DIRECTIONS.index(@facing) ,@increment)]
  end

  def calculate(start, length)
    start += length 
  end

  def determine_from(command)
    commands = command.split
    number = commands.inject(0) do |sum, direction|
      if direction == 'L'
        sum -= 1
      elsif direction == 'R'
        sum += 1
      end
    end
  end

  def current_location
    "#{@x.to_s} #{@y.to_s} #{@facing}"
  end
end

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
