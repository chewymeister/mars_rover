class Locator 
  attr_reader :x
  attr_reader :y
  attr_reader :cardinal

  def initialize(coords)
    @x = coords[:x]
    @y = coords[:y]
    @cardinal = coords[:cardinal]
  end
end
