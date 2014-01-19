class StringManipulator
  def initialize(input_string)
    @input_string = process(input_string)
  end
  
  def process(input_string)
    input_string.split("\n")    
  end

  def output
    contains_boundaries? ? output_with_boundaries : output_without_boundaries
  end

  def contains_boundaries?
    @input_string.first =~ /\d{2}\s\d{2}/
  end

  def output_with_boundaries
    {
      boundaries: provide_boundaries,
      instructions: provide_instructions
    }
  end

  def provide_instructions
    {
      coordinates: provide_coordinates
    }
  end

  def provide_coordinates
    { x: 0, y: 1, cardinal: 'N' }
  end

  def provide_boundaries
    { upper_x: upper_x, upper_y: upper_y }
  end

  def output_without_boundaries
    {
      instruction: {}
    }
  end

  def upper_x
    list_of(boundaries).first.to_i
  end

  def upper_y
    list_of(boundaries).last.to_i
  end

  def boundaries
    @input_string.first
  end

  def list_of(string)
    string.split(' ')
  end
end
