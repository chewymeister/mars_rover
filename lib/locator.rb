class Locator 
  ONE_STEP_IN = { 'N' => 1, 'S' => -1, 'E' => 1, 'W' => -1 }
  DIRECTIONS = ['N','E','S','W']

  attr_reader :x
  attr_reader :y
  attr_reader :card_index


  def card_index
    @cardinal_index
  end

  def initialize(coords)
    @x = coords[:x]
    @y = coords[:y]
    cardinal_index(coords)
  end

  def cardinal_index(coords)
    @cardinal_index = DIRECTIONS.index(coords[:cardinal])  
  end

  def current_direction
    DIRECTIONS[@cardinal_index]
  end

  def turn_left
    @cardinal_index -= 1 
  end

  def turn_right
    @cardinal_index += 1
  end

  def forward
    facing_north_or_south? ? move_vertically : move_horizontally
  end

  def move_horizontally
    @x += ONE_STEP_IN[current_direction]
  end

  def move_vertically
    @y += ONE_STEP_IN[current_direction]
  end

  def facing_north_or_south?
    current_direction == 'N' || current_direction == 'S'
  end

  def current_location
    "#{@x} #{@y} #{current_direction}"
  end

  def receive(coords)
    @x, @y = coords[:x], coords [:y]
  end
end
