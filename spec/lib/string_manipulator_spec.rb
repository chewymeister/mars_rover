require 'spec_helper'

describe StringManipulator do
  context 'extracts the boundary' do
    context 'should identify upper x boundary' do
      it 'as 10' do
        manipulator = StringManipulator.new('10 10')

        expect(manipulator.output[:boundaries][:upper_x]).to eq 10
      end

      it 'as 2000' do
        manipulator = StringManipulator.new('1000 2000')

        expect(manipulator.output[:boundaries][:upper_x]).to eq 1000
      end
    end

    context 'should identify upper y boundary' do
      it 'as 10' do
        manipulator = StringManipulator.new('10 10')

        expect(manipulator.output[:boundaries][:upper_y]).to eq 10
      end

      it 'as 2000' do
        manipulator = StringManipulator.new('2000 2000')

        expect(manipulator.output[:boundaries][:upper_y]).to eq 2000
      end
    end
  end

  context 'extracts the instructions' do
    context 'identifies the starting coordinates' do
      context 'are 0 1 N' do
        let(:string) do
          <<-eos
            20 20
            0 1 N
            F
          eos
        end

        it 'with the x coord being 0' do
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:coords][:x]).to eq 0
        end

        it 'with the y coord being 0' do
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:coords][:y]).to eq 1
        end

        it 'with the cardinal coord being "N"' do
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:coords][:cardinal]).to eq 'N'
        end
      end

      context 'are 5 5 S' do
        let(:string) do
          <<-eos
            20 20
            5 6 S
            F
          eos
        end

        it 'with the x coord being 0' do
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:coords][:x]).to eq 5
        end

        it 'with the y coord being 0' do
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:coords][:y]).to eq 6
        end

        it 'with the cardinal coord being "S"' do
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:coords][:cardinal]).to eq 'S'
        end
      end
    end

    context 'extracts the commands' do
      context 'with a string that contains boundaries' do
        it 'as MMM' do
          string = <<-eos
            20 20
            5 6 S
            MMM
          eos
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:commands]).to eq 'MMM'
        end

        it 'as LMLMLMLMLRRLMLMRLRLRLRLMLR' do
          string = <<-eos
            20 20
            5 6 S
            LMLMLMLMLRRLMLMRLRLRLRLMLR
          eos
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:commands]).to eq 'LMLMLMLMLRRLMLMRLRLRLRLMLR'
        end
      end
      context 'without a string that contains boundaries' do
        it 'as MMM' do
          string = <<-eos
            5 6 S
            MMM
          eos
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:commands]).to eq 'MMM'
        end

        it 'as LMLMLMLMLRRLMLMRLRLRLRLMLR' do
          string = <<-eos
            5 6 S
            LMLMLMLMLRRLMLMRLRLRLRLMLR
          eos
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][:commands]).to eq 'LMLMLMLMLRRLMLMRLRLRLRLMLR'
        end
      end
    end
  end
end
