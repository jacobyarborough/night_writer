require 'rspec'
require './lib/braille_converter'
require './lib/braille_logic'
describe BrailleLogic do
  before(:each) do
    @file_array = ['./data/message.txt','./data/braille.txt']
    @logic = BrailleLogic.new(@file_array)
  end
  describe '#initialize' do
    it 'creates an instance of BrailleLogic' do
      expect(@logic).to be_an_instance_of(BrailleLogic)
    end

    it 'has readable_attributes' do
      expect(@logic.read_file).to eq('./data/message.txt')
      expect(@logic.write_file).to eq('./data/braille.txt')
      expect(@logic.converter).to be_an_instance_of(BrailleConverter)
    end
  end

  describe '#braille_conversion_logic' do
    it 'reads an english text file and writes a braille translation' do
      File.write(@file_array[1],'')
      @logic.braille_conversion_logic
      expected = ["0.0.0.0.0....00.0.0.00\n", "00.00.0..0..00.0000..0\n",
        "....0.0.0....00.0.0...\n"]

      expect(File.readlines(@file_array[1])).to be_an(Array)
      expect(File.readlines(@file_array[1])).to eq(expected)
    end
  end
end
