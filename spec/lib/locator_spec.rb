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

    it 'reassign coords when given new coords' do
      expect(locator.current_location).to eq '0 0 N'
      new_coords = { x: 2, y: 2, cardinal: 'S' }
      locator.receive(new_coords)

      expect(locator.current_location).to eq '2 2 S'
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
  end

  context 'when moving forward' do
    context 'along y axis' do
      it 'increments y axis by one when facing north' do
        locator.forward

        expect(locator.current_location).to eq '0 1 N'
      end

      it 'increments y axis by two when facing north' do
        2.times { locator.forward }

        expect(locator.current_location).to eq '0 2 N'
      end

      it 'decrements y axis by two when facing south' do
        south_coords = { x: 5, y: 5, cardinal: 'S' }
        south_facing_locator = Locator.new(south_coords) 
        2.times { south_facing_locator.forward }

        expect(south_facing_locator.current_location).to eq '5 3 S'
      end
    end

    context 'along x axis' do
      it 'increments x axis by one when facing east' do
        east_coords = { x: 5, y: 5, cardinal: 'E' }
        east_facing_locator = Locator.new(east_coords)
        east_facing_locator.forward

        expect(east_facing_locator.current_location).to eq '6 5 E'
      end

      it 'increments x axis by two when facing east' do
        east_coords = { x: 5, y: 5, cardinal: 'E' }
        east_facing_locator = Locator.new(east_coords)
        2.times {east_facing_locator.forward}

        expect(east_facing_locator.current_location).to eq '7 5 E'
      end

      it 'decrements x axis by two when facing west' do
        west_coords = { x: 5, y: 5, cardinal: 'W' }
        west_facing_locator = Locator.new(west_coords)
        2.times {west_facing_locator.forward}

        expect(west_facing_locator.current_location).to eq '3 5 W'
      end
    end
  end
end
