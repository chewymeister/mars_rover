class RoverInterface
  def receive(input_as_string)
    @processor = InputProcessor.new(input_as_string)
    @data = @processor.output
  end

  def output
    extract_rover_locations_into_string.rstrip
  end

  def extract_rover_locations_into_string
    initiate_rovers.inject('') { |output, rover| output += location_of(rover) }
  end

  def location_of(rover)
    "#{rover.current_location}\n"
  end

  def initiate_rovers
    list_of_instructions.inject([]) do |rovers, instructions|
      rovers << new_rover_with(instructions)
    end
  end

  def new_rover_with(instructions)
    Rover.new(processed_input_from(instructions))
  end

  def list_of_instructions
    @data[:instructions]
  end

  def boundaries
    @data[:boundaries]
  end

  def processed_input_from(instructions)
    { boundaries: boundaries, instructions: instructions }
  end
end
