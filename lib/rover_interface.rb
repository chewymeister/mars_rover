class RoverInterface
  def receive(input)
    @input = input
    @processor = StringManipulator.new(input)
    @data = @processor.output
    @boundaries = @data[:boundaries]
  end

  def output
    @rovers = @data[:instructions].inject([]) do |collection, instruction|
      processed_input = { boundaries: @boundaries, instructions: instruction }
      collection << Rover.new(processed_input)
    end

    @rovers.inject('') do |string, rover|
     string += "#{rover.current_location}\n"
    end.rstrip
  end
end
