require 'spec_helper'
describe Locator do
  let(:north_facing_locator) { Locator.new(coords('N'), boundaries([10,10])) }
  let(:south_facing_locator) { Locator.new(coords('S'), boundaries([10,10])) }
  let(:east_facing_locator) { Locator.new(coords('E'), boundaries([10,10])) }
  let(:west_facing_locator) { Locator.new(coords('W'), boundaries([10,10])) }

  context 'turning left and right' do
    it 'knows it is facing north' do
      expect(north_facing_locator.current_location).to eq '5 5 N'
    end

    it 'knows it is facing south' do
      expect(south_facing_locator.current_location).to eq '5 5 S'
    end

    context 'when turning left' do
      it 'new direction is west with one left turn' do
        north_facing_locator.turn_left

        expect(north_facing_locator.current_location).to eq '5 5 W'
      end

      it 'new direction is south with two left turns' do
        2.times { north_facing_locator.turn_left }

        expect(north_facing_locator.current_location).to eq '5 5 S'
      end

      it 'new direction is east with seven left turns' do
        7.times { north_facing_locator.turn_left }

        expect(north_facing_locator.current_location).to eq '5 5 E'
      end

      it 'new direction is west with thirty three left turns' do
        33.times { north_facing_locator.turn_left }

        expect(north_facing_locator.current_location).to eq '5 5 W'
      end
    end

    context 'when turning right' do
      it 'new direction is east with one right turn' do
        north_facing_locator.turn_right

        expect(north_facing_locator.current_location).to eq '5 5 E'
      end

      it 'new direction is south with two right turns' do
        2.times { north_facing_locator.turn_left }

        expect(north_facing_locator.current_location).to eq '5 5 S'
      end

      it 'new direction is south with six right turns' do
        6.times { north_facing_locator.turn_right }

        expect(north_facing_locator.current_location).to eq '5 5 S'
      end

      it 'new direction is south with twenty three right turns' do
        23.times { north_facing_locator.turn_right }

        expect(north_facing_locator.current_location).to eq '5 5 W'
      end
    end
  end

  context 'when moving forward' do
    context 'along y axis' do
      it 'increments y coordinate by one when facing north' do
        north_facing_locator.forward

        expect(north_facing_locator.current_location).to eq '5 6 N'
      end

      it 'increments y coordinate by two when facing north' do
        2.times { north_facing_locator.forward }

        expect(north_facing_locator.current_location).to eq '5 7 N'
      end

      it 'decrements y coordinate by two when facing south' do
        2.times { south_facing_locator.forward }

        expect(south_facing_locator.current_location).to eq '5 3 S'
      end
    end

    context 'along x axis' do
      it 'increments x coordinate by one when facing east' do
        east_facing_locator.forward

        expect(east_facing_locator.current_location).to eq '6 5 E'
      end

      it 'increments x coordinate by two when facing east' do
        2.times { east_facing_locator.forward }

        expect(east_facing_locator.current_location).to eq '7 5 E'
      end

      it 'decrements x coordinate by two when facing west' do
        2.times {west_facing_locator.forward}

        expect(west_facing_locator.current_location).to eq '3 5 W'
      end
    end
  end

  context 'receives series of commands' do
    let(:locator) { Locator.new(coords('N'), boundaries([10,10])) }

    it 'current location should be "4 6 N"' do
      locator.turn_left
      locator.forward
      locator.turn_right
      locator.forward

      expect(locator.current_location).to eq '4 6 N'
    end

    context 'cannot travel outside the boundaries' do
      it 'current location should be "5 0 S", does not travel past zero on y axis' do
        2.times { locator.turn_left }
        10.times { locator.forward }

        expect(locator.current_location).to eq '5 0 S'
      end

      it 'current location should be "0 5 W", does not travel past zero on x axis' do
        locator.turn_left
        10.times { locator.forward }

        expect(locator.current_location).to eq '0 5 W'
      end

      it 'current location should be "10 5 E", does not travel past upper x boundary' do
        locator.turn_right
        20.times { locator.forward }

        expect(locator.current_location).to eq '10 5 E'
      end

      it 'current location should be "6 5 W", resumes travel after hitting a boundary' do
        locator.turn_right
        20.times { locator.forward }
        2.times { locator.turn_left }
        4.times { locator.forward }

        expect(locator.current_location).to eq '6 5 W'
      end
    end
  end

  def coords(direction)
    { x: 5, y: 5, cardinal: direction }
  end

  def new_position(coords)
    { x: coords[0], y: coords[1], cardinal: coords[2] }
  end

  def boundaries(coords)
    { upper_x: coords[0], upper_y: coords[1] }
  end
end
