class Rover
  DIRECTIONS = ['N','E','S','W']
  FACING = { 'L' => -1, 'R' => 1 }
  ONE_STEP_IN = { 'N' => 1, 'S' => -1, 'E' => 1, 'W' => -1 }

  def move(coords, command)
    assign(coords) 
    determine_move_from(command)
  end

  def current_location
    "#{@x.to_s} #{@y.to_s} #{current_direction}"
  end

  private

  def assign(coords)
    @x, @y, @cardinal_index = x(coords), y(coords), cardinal(coords) 
  end

  def cardinal(coords)
    DIRECTIONS.index(list(coords)[2])
  end

  def y(coords)
    list(coords)[1].to_i
  end

  def x(coords)
    list(coords)[0].to_i
  end
  
  def list(coords)
    coords.split(' ')
  end

  def current_direction
    DIRECTIONS[@cardinal_index]
  end

  def determine_move_from(commands)
    list_of(commands).each do |direction|
      if turn_left_or_right?(direction)
        turn_to_face(direction)
      else
        move_a_space
      end
    end
  end

  def turn_left_or_right?(direction)
    direction == 'L' || direction == 'R'
  end

  def turn_to_face(direction)
    @cardinal_index += FACING[direction]
  end

  def list_of(command)
    command.chars
  end

  def move_a_space
    if facing_north_or_south?
      go_vertical
    else
      go_horizontal
    end
  end

  def go_horizontal
    @x += ONE_STEP_IN[current_direction]
  end

  def go_vertical
    @y += ONE_STEP_IN[current_direction]
  end

  def facing_north_or_south?
    current_direction == 'N' || current_direction == 'S'
  end
end
