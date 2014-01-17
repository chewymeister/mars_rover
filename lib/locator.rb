class Locator 
  attr_reader :x

  def initialize(coords)
    @x = coords[:x]
  end
end
