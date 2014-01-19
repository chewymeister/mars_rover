require 'spec_helper'

describe StringManipulator do
  context 'extracts the boundary' do
    context 'of value 10 10' do
      let(:manipulator) { StringManipulator.new('10 10') }

      it 'upper_x is 10' do
        expect(manipulator.output[:boundaries][:upper_x]).to eq 10
      end

      it 'upper_y is 10' do
        expect(manipulator.output[:boundaries][:upper_y]).to eq 10
      end
    end

    context 'of value 2000 2000' do
      let(:manipulator) { StringManipulator.new('2000 2000') }
      it 'upper_x is 2000' do
        expect(manipulator.output[:boundaries][:upper_x]).to eq 2000
      end

      it 'upper_y is 2000' do
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
            M
          eos
        end
        let(:manipulator) { StringManipulator.new(string) }

        it 'with the x coord being 0' do
          expect(manipulator.output[:instructions][0][:coords][:x]).to eq 0
        end

        it 'with the y coord being 0' do
          expect(manipulator.output[:instructions][0][:coords][:y]).to eq 1
        end

        it 'with the cardinal coord being "N"' do
          expect(manipulator.output[:instructions][0][:coords][:cardinal]).to eq 'N'
        end
      end

      context 'are 5 5 S' do
        let(:string) do
          <<-eos
            20 20
            5 6 S
            M
          eos
        end
        let(:manipulator) { StringManipulator.new(string) }

        it 'with the x coord being 0' do
          expect(manipulator.output[:instructions][0][:coords][:x]).to eq 5
        end

        it 'with the y coord being 0' do
          expect(manipulator.output[:instructions][0][:coords][:y]).to eq 6
        end

        it 'with the cardinal coord being "S"' do
          expect(manipulator.output[:instructions][0][:coords][:cardinal]).to eq 'S'
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

          expect(manipulator.output[:instructions][0][:commands]).to eq 'MMM'
        end

        it 'as LMLMLMLMLRRLMLMRLRLRLRLMLR' do
          string = <<-eos
            20 20
            5 6 S
            LMLMLMLMLRRLMLMRLRLRLRLMLR
          eos
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][0][:commands]).to eq 'LMLMLMLMLRRLMLMRLRLRLRLMLR'
        end
      end

      context 'with a string that does not contain boundaries' do
        it 'as MMM' do
          string = <<-eos
            5 6 S
            MMM
          eos
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][0][:commands]).to eq 'MMM'
        end

        it 'as LMLMLMLMLRRLMLMRLRLRLRLMLR' do
          string = <<-eos
            5 6 S
            LMLMLMLMLRRLMLMRLRLRLRLMLR
          eos
          manipulator = StringManipulator.new(string)

          expect(manipulator.output[:instructions][0][:commands]).to eq 'LMLMLMLMLRRLMLMRLRLRLRLMLR'
        end
      end
    end
  end

  context 'handles multiple commands' do
    let(:string) do
      <<-eos
        10 10
        5 6 S
        M
        7 7 N
        LMRMLLM
      eos
    end
    let(:manipulator) { StringManipulator.new(string) }
    let(:first_result) { { coords: { x: 5, y: 6, cardinal: 'S' }, commands: 'M' } }
    let(:second_result) { { coords: { x: 7, y: 7, cardinal: 'N' }, commands: 'LMRMLLM' } }

    it 'first set of instructions should equal first result' do
      expect(manipulator.output[:instructions].first).to eq first_result
    end

    it 'second set of instructions should equal second result' do
      expect(manipulator.output[:instructions].last).to eq second_result
    end
  end
end
