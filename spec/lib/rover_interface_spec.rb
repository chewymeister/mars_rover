require 'spec_helper'

describe RoverInterface do
  let(:interface) { RoverInterface.new }  

  context 'with a single command' do
    it 'should have an output of "0 0 W"' do
      input = <<-eos
      20 20
      0 0 N
      L
      eos
      interface.receive(input)

      expect(interface.output).to eq '0 0 W' 
    end

    it 'should have an output of "0 0 E"' do
      input = <<-eos
      20 20
      0 0 N
      R
      eos
      interface.receive(input)

      expect(interface.output).to eq '0 0 E' 
    end
  end

  context 'with multiple commands' do
    it 'should have an output of "3 3 E"' do
      input = <<-eos
        20 20
        0 0 N
        LMMRMMMRMMM
      eos
      interface.receive(input)

      expect(interface.output).to eq '3 3 E' 
    end

    it 'should have an output of "1 2 W"' do
      input = <<-eos
        20 20
        0 0 N
        RMMMLMLMMRML
      eos
      interface.receive(input)

      expect(interface.output).to eq '1 2 W' 
    end

    context 'with a large boundary' do
      it 'should have an output of "47 35 S"' do
        input = <<-eos
          100 100
          25 32 E
          MMMMMMMMMMMMMMMMMLMMMMMMMMRMMMMMRMMMMM
        eos
        interface.receive(input)

        expect(interface.output).to eq '47 35 S' 
      end
    end
  end

  context 'with multiple instructions' do
    it 'should have an output of "1 2 W", and "8 10 W"' do
      input = <<-eos
        20 20
        0 0 N
        RMMMLMLMMRML
        10 10 S
        MMRMRMMLM
      eos
        
      interface.receive(input)

      expect(interface.output).to eq "1 2 W\n8 10 W" 
    end
  end
end
