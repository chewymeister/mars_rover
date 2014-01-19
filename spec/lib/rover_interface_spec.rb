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
end

