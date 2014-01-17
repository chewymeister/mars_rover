require 'spec_helper'

describe Locator do
  let(:coords) { { x: 0, y: 0, cardinal: 'N' } }
  let(:locator) { Locator.new(coords) }
  context 'assigns coords' do

    it 'should know the x coordinate' do
      expect(locator.x).to eq 0
    end

    it 'should know the y coordinate' do
      expect(locator.y).to eq 0
    end
  end

  context 'turning left and right' do
    it 'knows it is facing north' do
      expect(locator.current_direction).to eq 'N'
    end

    it 'knows it is facing south' do
      coords = { x: 0, y: 0, cardinal: 'S' }
      locator = Locator.new(coords)

      expect(locator.current_direction).to eq 'S'
    end

    context 'when turning left' do
      it 'current direction is west with one left turn' do
        locator.turn_left

        expect(locator.current_direction).to eq 'W'
      end

      it 'current direction is south with two left turns' do
        2.times { locator.turn_left }

        expect(locator.current_direction).to eq 'S'
      end
    end

    context 'when turning right' do
      it 'current direction is east with one right turn' do
        locator.turn_right

        expect(locator.current_direction).to eq 'E'
      end

      it 'current direction is south with two right turns' do
        2.times { locator.turn_left }

        expect(locator.current_direction).to eq 'S'
      end
    end

    context 'when moving forward' do
      it 'increments y axis by one when facing north' do
        locator.forward

        expect(locator.current_location).to eq '0 1 N'
      end

      it 'increments y axis by two when facing north' do
        2.times { locator.forward }

        expect(locator.current_location).to eq '0 2 N'
      end
    end
  end
end
