class Locator 
  DIRECTIONS = ['N','E','S','W']
  attr_reader :x
  attr_reader :y
  attr_reader :cardinal

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
end
