require 'spec_helper'

describe StringManipulator do
  context 'extracts the boundary' do
    context 'should identify upper x boundary' do
      it 'as 10' do
        manipulator = StringManipulator.new('10 10')

        expect(manipulator.output[:boundaries][:upper_x]).to eq 10
      end

      it 'as 20' do
        manipulator = StringManipulator.new('20 20')

        expect(manipulator.output[:boundaries][:upper_x]).to eq 20
      end
    end

    context 'should identify upper y boundary' do
      it 'as 10' do
        manipulator = StringManipulator.new('10 10')

        expect(manipulator.output[:boundaries][:upper_y]).to eq 10
      end

      it 'as 20' do
        manipulator = StringManipulator.new('20 20')

        expect(manipulator.output[:boundaries][:upper_y]).to eq 20
      end
    end
  end

  context 'extracts the instructions' do
    context 'should identify the starting coordinates' do
      let(:string) do
        <<-eos
        20 20
        0 1 N
        F
        eos
      end
      it 'with the x coord being 0' do
        manipulator = StringManipulator.new(string)

        expect(manipulator.output[:instructions][:coordinates][:x]).to eq 0
      end

      it 'with the y coord being 0' do
        manipulator = StringManipulator.new(string)

        expect(manipulator.output[:instructions][:coordinates][:y]).to eq 1
      end
    end
  end

end
