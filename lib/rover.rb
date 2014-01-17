class Rover
  DIRECTIONS = ['N','E','S','W']
  FACING = { 'L' => -1, 'R' => 1 }
  ONE_STEP_IN = { 'N' => 1, 'S' => -1, 'E' => 1, 'W' => -1 }
  
  def initialize(coords)
    @locator = Locator.new(coords)
  end

  def move(coords, command)
    @locator.receive(processed(coords))
    determine_path_from(command)
  end

  def processed(coords)
    { x: coords[0].to_i, y: coords[1].to_i }
  end

  def current_location
    @locator.current_location
  end

  private

  def determine_path_from(commands)
    list_of(commands).each { |direction| choose(direction) }
  end

  def choose(direction)
    puts turn_left_or_right?(direction)
    turn_left_or_right?(direction) ? turn_to_face(direction) : @locator.forward
  end

  def turn_to_face(direction)
    direction == 'L' ? @locator.turn_left : @locator.turn_right
  end

  def turn_left_or_right?(direction)
    direction == 'L' || direction == 'R'
  end

  def list_of(command)
    command.chars
  end
end
