require 'rspec'
require './lib/english_converter'
require './lib/english_logic'
describe EnglishLogic do
  before(:each) do
    @file_array = ['./data/braille.txt','./data/original_message.txt']
    @logic = EnglishLogic.new(@file_array)
  end
  describe '#initialize' do
    it 'creates an instance of BrailleLogic' do
      expect(@logic).to be_an_instance_of(EnglishLogic)
    end

    it 'has readable_attributes' do
      expect(@logic.read_file).to eq('./data/braille.txt')
      expect(@logic.write_file).to eq('./data/original_message.txt')
      expect(@logic.converter).to be_an_instance_of(EnglishConverter)
    end
  end

  describe '#english_conversion_logic' do
    it 'reads a braille text file and writes an english translation' do
      File.write(@file_array[1],'')
      @logic.english_conversion_logic
      expected = ["hello world\n"]

      expect(File.readlines(@file_array[1])).to be_an(Array)
      expect(File.readlines(@file_array[1])).to eq(expected)
    end
  end
end
