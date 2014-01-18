class Locator 
  ONE_STEP_IN = { 'N' => 1, 'S' => -1, 'E' => 1, 'W' => -1 }
  DIRECTIONS = ['N','E','S','W']

  def initialize(coords, boundaries)
    set(coords) & lay(boundaries)
  end

  def lay(boundaries)
    @upper_x, @upper_y = boundaries[:upper_x], boundaries[:upper_y]
  end

  def set(coords)
    @x, @y, @cardinal = coords[:x], coords [:y], cardinal_to_integer(coords)
  end

  def cardinal_to_integer(coords)
    DIRECTIONS.index(coords[:cardinal])  
  end

  def current_direction
    DIRECTIONS[@cardinal % DIRECTIONS.size]
  end

  def turn_left
    @cardinal -= 1 
  end

  def turn_right
    @cardinal += 1
  end

  def forward
    facing_north_or_south? ? move_vertically : move_horizontally
  end

  def move_horizontally
    take_step_along_x unless outside_x_boundaries
  end

  def outside_x_boundaries
    @x == 0 || @x >= @upper_x
  end

  def take_step_along_x
    @x += ONE_STEP_IN[current_direction]
  end

  def move_vertically
    take_step_along_y unless outside_y_boundaries
  end

  def outside_y_boundaries
    @y == 0 || @y >= @upper_x
  end

  def take_step_along_y
    @y += ONE_STEP_IN[current_direction]
  end

  def facing_north_or_south?
    current_direction == 'N' || current_direction == 'S'
  end

  def current_location
    "#{@x} #{@y} #{current_direction}"
  end
end
