class Rover
  DIRECTIONS = ['N','E','S','W']
  attr_reader :facing

  def move(location, command)
    coords = location.split(' ')
    @x = coords[0].to_i
    @y = coords[1].to_i
    @facing = DIRECTIONS.index(coords[2])
    determine_from(command)
  end

  def calculate(start, length)
    start += length 
  end

  def current_direction
    DIRECTIONS[@facing]
  end

  def determine_from(command)
    commands = command.chars
    commands.each do |direction|
      if direction == 'L'
        @facing -= 1
      elsif direction == 'R'
        @facing += 1
      else
        move_a_space
      end
    end
  end

  def move_a_space
    if current_direction == 'N'
      @y += 1
    elsif current_direction == 'E'
      @x += 1
    elsif current_direction == 'S'
      @y -= 1
    elsif current_direction == 'W'
      @x -= 1
    end
  end

  def current_location
    "#{@x.to_s} #{@y.to_s} #{current_direction}"
  end
end
