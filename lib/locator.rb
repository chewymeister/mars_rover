class Locator 
  STEP_REFERENCE = { 'N' => 1, 'S' => -1, 'E' => 1, 'W' => -1 }
  CARDINAL_REFERENCE = ['N','E','S','W']

  def initialize(coords, boundaries)
    set(coords) 
    lay(boundaries)
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

  def current_location
    "#{@x} #{@y} #{current_direction}"
  end

  def set(coords)
    @x, @y, @cardinal = coords[:x], coords [:y], cardinal_to_integer(coords)
  end

  private

  def lay(boundaries)
    @upper_x, @upper_y = boundaries[:upper_x], boundaries[:upper_y]
  end

  def cardinal_to_integer(coords)
    CARDINAL_REFERENCE.index(coords[:cardinal])
  end

  def move_horizontally
    take_step_along_x unless outside_x_boundaries
  end

  def outside_x_boundaries
    0 > @x + next_step || @x + next_step > @upper_x
  end

  def take_step_along_x
    @x += next_step
  end

  def move_vertically
    take_step_along_y unless outside_y_boundaries
  end

  def outside_y_boundaries
    0 > @y + next_step || @y + next_step > @upper_y
  end

  def take_step_along_y
    @y += next_step
  end

  def next_step
    STEP_REFERENCE[current_direction]
  end

  def facing_north_or_south?
    current_direction == 'N' || current_direction == 'S'
  end

  def current_direction
    CARDINAL_REFERENCE[@cardinal % CARDINAL_REFERENCE.size]
  end
end
