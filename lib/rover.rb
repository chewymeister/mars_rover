class Rover
  FACING = { 'L' => -1, 'R' => 1 }
  
  def initialize(input)
    @boundaries = input[:boundaries]
    give_locator(coords_from(input[:instructions])) 
    determine_path_from(commands_from(input[:instructions]))
  end

  def current_location
    @locator.current_location
  end

  private

  def commands_from(instructions)
    instructions[:commands] 
  end

  def coords_from(instructions)
    instructions[:coords]
  end

  def give_locator(coords)
    @locator = Locator.new(coords, @boundaries)
  end

  def determine_path_from(commands)
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

  def separate(command)
    command.chars
  end
end
