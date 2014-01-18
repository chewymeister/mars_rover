require 'spec_helper'

describe StringManipulator do
  context 'extracts the boundary' do
    context 'should identify upper x boundary' do
      it 'as 10' do
        manipulator = StringManipulator.new('10 10')

        expect(manipulator.output[:boundary][:upper_x]).to eq 10
      end

      it 'as 20' do
        manipulator = StringManipulator.new('20 20')

        expect(manipulator.output[:boundary][:upper_x]).to eq 20
      end
    end

    context 'should identify upper y boundary' do
      it 'as 10' do
        manipulator = StringManipulator.new('10 10')

        expect(manipulator.output[:boundary][:upper_y]).to eq 10
      end

      it 'as 20' do
        manipulator = StringManipulator.new('20 20')

        expect(manipulator.output[:boundary][:upper_y]).to eq 20
      end
    end
  end
end
