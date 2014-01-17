class Locator 
  attr_reader :x
  attr_reader :y

  def initialize(coords)
    @x = coords[:x]
    @y = coords[:y]
  end
end
