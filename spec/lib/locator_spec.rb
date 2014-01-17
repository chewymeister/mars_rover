require 'spec_helper'

describe Locator do
  it 'should know the x coordinate' do
    coords = { x: 0, y: 0, cardinal: 'N' }
    locator = Locator.new(coords)

    expect(locator.x).to eq 0
  end

  it 'should know the y coordinate' do
    coords = { x: 0, y: 0, cardinal: 'N' }
    locator = Locator.new(coords)

    expect(locator.y).to eq 0
  end
end
