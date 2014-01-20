class InputProcessor
  def self.process(input_string)
    self.new(input_string)
  end

  def initialize(input_string)
    @input_string = process(input_string)
  end

  def output
    { boundaries: set_boundaries, instructions: set_instructions }
  end
  
  private

  def process(string)
    sentence_list_from(string).map(&:strip)
  end

  def sentence_list_from(string)
    string.split("\n")
  end

  def set_instructions
    extract_instructions_using(input_without_boundaries)
  end

  def input_without_boundaries
    @input_string.drop(1)
  end

  def extract_instructions_using(commands_and_coords)
    paired_up(commands_and_coords).inject([]) do |list_of_instructions, pair|
      list_of_instructions << hash_of_coords_and_commands_from(pair)
    end
  end

  def hash_of_coords_and_commands_from(pair)
    { :coords => create_coords_using(pair.first), :commands => pair.last }
  end

  def paired_up(commands_and_coords)
    commands_and_coords.each_slice(2)
  end

  def create_coords_using(coords_string)
    { 
      x: first_number_from(coords_string), 
      y: second_number_from(coords_string), 
      cardinal: last_letter_from(coords_string)
    }
  end

  def first_number_from(string)
    coords_from(string,0)
  end

  def second_number_from(string)
    coords_from(string,1)
  end

  def last_letter_from(string)
    words_from(string).last
  end

  def coords_from(coords, index)
    words_from(coords)[index].to_i
  end

  def set_boundaries
    { upper_x: upper_x, upper_y: upper_y }
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
