class Rover
  FACING = { 'L' => -1, 'R' => 1 }
  
  def initialize(boundaries)
    @boundaries = boundaries
  end

  def current_location
    @locator.current_location
  end

  def move(coords, command)
    give_locator(coords) 
    determine_path_from(command)
  end

  private

  def give_locator(coords)
    @locator = Locator.new(processed(coords), @boundaries)
  end

  def processed(coords)
    { x: take(coords, 0), y: take(coords, 1), cardinal: list(coords)[2]}
  end

  def take(coords, index)
    list(coords)[index].to_i
  end

  def list(coords)
    coords.split(' ')
  end

  def determine_path_from(commands)
    list_of(commands).each { |direction| choose(direction) }
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

  def list_of(command)
    command.chars
  end
end
