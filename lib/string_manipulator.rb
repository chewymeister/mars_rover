class StringManipulator
  BOUNDARY = /^(\d+)\s(\d+)$/
  INSTRUCTION = /^\w+$/

  def initialize(input_string)
    @input_string = process(input_string)
  end

  def output
    {
      boundaries: set_boundaries,
      instructions: set_instructions
    }
  end
  
  private

  def set_instructions
    contains_instructions? ? provide_instructions : ''
  end

  def process(string)
    sentence_list_from(string).map(&:strip)
  end

  def sentence_list_from(string)
    string.split("\n")
  end

  def contains_instructions?
    @input_string.any? { |string| string =~ INSTRUCTION }
  end

  def provide_instructions
    extract_instructions(without_boundaries)
  end

  def without_boundaries
    @input_string.reject { |string| string =~ BOUNDARY}
  end

  def extract_instructions(instructions)
    instructions.each_slice(2).inject([]) do |list, pair|
      list << {
        :commands => extract_commands_from(pair),
        :coords => extract_coords_from(pair)
      }
    end
  end

  def extract_commands_from(pair)
    pair.select { |string| string =~ INSTRUCTION }.first
  end

  def extract_coords_from(pair)
    create_coords_using(coord_containing(pair))
  end

  def coord_containing(pair)
    pair.reject { |string| string =~ INSTRUCTION }.first
  end

  def create_coords_using(coords)
    {
      x: coords_from(coords,0), 
      y: coords_from(coords,1), 
      cardinal: word_list_from(coords)[2]
    }
  end

  def coords_from(coords, index)
    word_list_from(coords)[index].to_i
  end

  def set_boundaries
    contains_boundaries? ? define_boundaries : @boundaries ||= ''
  end

  def define_boundaries
    @boundaries = { upper_x: upper_x, upper_y: upper_y }
  end

  def contains_boundaries?
    @input_string.first =~ BOUNDARY
  end

  def upper_x
    word_list_from(boundaries).first.to_i
  end

  def upper_y
    word_list_from(boundaries).last.to_i
  end

  def boundaries
    @input_string.first
  end

  def word_list_from(string)
    string.split(' ')
  end
end
