class Rover
  FACING = { 'L' => -1, 'R' => 1 }
  
  def initialize(input)
    @locator = give_locator(coords_from(input), input[:boundaries]) 
    determine_path_using(commands_from(input))
  end

  def current_location
    @locator.current_location
  end

  private

  def commands_from(input)
    input[:instructions][:commands] 
  end

  def coords_from(input)
    input[:instructions][:coords]
  end

  def give_locator(coords, boundaries)
    Locator.new(coords, boundaries)
  end

  def determine_path_using(commands)
    separate(commands).each { |direction| choose(direction) }
  end

  def choose(direction)
    turn_left_or_right?(direction) ? turn_to_face(direction) : @locator.forward
  end

  def turn_to_face(direction)
    direction == 'L' ? @locator.turn_left : @locator.turn_right
  end

  def turn_left_or_right?(direction)
    direction == 'L' || direction == 'R'
  end

  def separate(commands)
    commands.chars
  end
end
