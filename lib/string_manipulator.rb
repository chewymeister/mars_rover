class StringManipulator
  BOUNDARY = /^(\d+)\s(\d+)$/
  COMMAND = /^\w+$/

  def initialize(input_string)
    @input_string = process(input_string)
  end

  def output
    { boundaries: set_boundaries, instructions: set_instructions }
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
    @input_string.any? { |string| string =~ COMMAND }
  end

  def provide_instructions
    extract_instructions(without_boundaries)
  end

  def without_boundaries
    @input_string.reject { |string| string =~ BOUNDARY}
  end

  def extract_instructions(commands_and_coords)
    paired_up(commands_and_coords).inject([]) do |list_of_instructions, pair|
      list_of_instructions << {
        :commands => extract_commands_from(pair),
        :coords => extract_coords_from(pair)
      }
    end
  end

  def paired_up(commands_and_coords)
    commands_and_coords.each_slice(2)
  end

  def extract_commands_from(pair)
    pair.select { |string| string =~ COMMAND }.first
  end

  def extract_coords_from(pair)
    create_coords_using(coords_string_from(pair))
  end

  def coords_string_from(pair)
    pair.reject { |string| string =~ COMMAND }.first
  end

  def create_coords_using(string)
    {
      x: coords_from(string,0), y: coords_from(string,1), cardinal: words_from(string)[2]
    }
  end

  def coords_from(coords, index)
    words_from(coords)[index].to_i
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
    words_from(boundaries).first.to_i
  end

  def upper_y
    words_from(boundaries).last.to_i
  end

  def boundaries
    @input_string.first
  end

  def words_from(string)
    string.split(' ')
  end
end
