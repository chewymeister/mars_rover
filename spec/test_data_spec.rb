require 'spec_helper'

describe RoverInterface do
  let(:interface) { RoverInterface.new }

  context 'using the data given by problem' do
    it 'should have the output "1 3 N" and "5 1 E"' do
      input = <<-eos
        5 5
        1 2 N
        LMLMLMLMM
        3 3 E
        MMRMMRMRRM
      eos
      interface.receive(input)

      expect(interface.output).to eq "1 3 N\n5 1 E"
    end
  end

  context 'further examples' do
    context 'within small boundaries, constantly reaches outer limits' do
      it 'should have the output "3 3 S" and "0 3 E' do
        input = <<-eos
          3 3
          1 1 N
          LLFFFFFFFFFRFFFFFFFFFRRFFFFFFFFFFFLFFFFFFFFLL
          2 3 S
          RRFFFFFFFFFFLFFFFFFFFLL
        eos
        interface.receive(input)

        expect(interface.output).to eq "3 3 S\n0 3 E"
      end
    end

    context 'with a large number of commands' do
      it 'should have the output "23 47 E" and "48 2 S"' do
        input = <<-eos
          50 50
          39 12 E
          LMMMMMMMMMMMMMLMMMMLMMMMMRMMMMMMMMMMMMRMMMMMMMMMMMMMMMMMMMMMMMMMMMR
          25 24 N
          MMLMMMMMLMMMMMMMMMMLMMMMMMMMMMMMMMMMMMMMMMMMMMMMRMMMMMMMMMMMMMM
        eos

        interface.receive(input)
        expect(interface.output).to eq "23 47 E\n48 2 S"
      end
    end

    context 'with a large number of rovers' do
      it 'should have an output of "4 4 S", "3 2 W" "2 3 E", "7 6 E" and "3 7 N"' do
        input = <<-eos
          10 10
          2 2 E
          MMLMMRR
          1 5 N
          RRMMMLMMLL
          0 0 S
          MMMLMMLMMMR
          9 8 W
          LMMRMMRR
          1 10 E
          MMRMMMLL
        eos
        interface.receive(input)

        expect(interface.output).to eq "4 4 S\n3 2 W\n2 3 E\n7 6 E\n3 7 N"
      end
    end
  end
end
