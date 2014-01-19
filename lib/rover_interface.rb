class RoverInterface
  def receive(input)
    @input = input
  end

  def output
    '0 0 W'
  end
end
