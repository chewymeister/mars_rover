class StringManipulator
  def initialize(input_string)
    @input_string = process(input_string)
  end

  def process(input_string)
    input_string.split("\n").map(&:strip)
  end

  def output
    {
      boundaries: provide_boundaries,
      instructions: contains_instructions? ? provide_instructions : ''
    }
  end

  def contains_instructions?
    @input_string.any? { |string| string =~ /^\w+$/ }
  end

  def provide_instructions
    contains_boundaries? ? extract_instructions(@input_string.drop(1)) : extract_instructions(@input_string)
  end

  def extract_instructions(set)
    {
      :commands => set.select { |string| string =~ /^\w+$/ }.first,
      :coords => provide_coords(set.reject { |string| string =~ /^\w+$/ }.first)
    }
  end

  def provide_coords(string)
    { x: list_of(string)[0].to_i, y: list_of(string)[1].to_i, cardinal: list_of(string)[2] }   
  end

  def provide_boundaries
    contains_boundaries? ? { upper_x: upper_x, upper_y: upper_y } : ''
  end

  def contains_boundaries?
    @input_string.first =~ /^(\d+)\s(\d+)$/
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
