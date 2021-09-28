require 'rspec'
require './lib/english_converter'
describe EnglishConverter do
  before(:each) do
    @file1 = './data/braille.txt'
    @file2 = './data/original_message.txt'
    @converter = EnglishConverter.new(@file1,@file2)
  end
  describe '#initialize' do
    it 'creates an instance of BrailleConverter' do
      expect(@converter).to be_an_instance_of(EnglishConverter)
    end

    it 'has readable attributes' do
      expected = {
        'a' => ['0.','..','..'],
        'b' => ['0.','0.','..'],
        'c' => ['00','..','..'],
        'd' => ['00','.0','..'],
        'e' => ['0.','.0','..'],
        'f' => ['00','0.','..'],
        'g' => ['00','00','..'],
        'h' => ['0.','00','..'],
        'i' => ['.0','0.','..'],
        'j' => ['.0','00','..'],
        'k' => ['0.','..','0.'],
        'l' => ['0.','0.','0.'],
        'm' => ['00','..','0.'],
        'n' => ['00','.0','0.'],
        'o' => ['0.','.0','0.'],
        'p' => ['00','0.','0.'],
        'q' => ['00','00','0.'],
        'r' => ['0.','00','0.'],
        's' => ['.0','0.','0.'],
        't' => ['.0','00','0.'],
        'u' => ['0.','..','00'],
        'v' => ['0.','0.','00'],
        'w' => ['.0','00','.0'],
        'x' => ['00','..','00'],
        'y' => ['00','.0','00'],
        'z' => ['0.','.0','00'],
        'A' => ['0.','..','..'],
        'B' => ['0.','0.','..'],
        'C' => ['0.','0.','..'],
        'D' => ['00','.0','..'],
        'E' => ['0.','.0','..'],
        'F' => ['00','0.','..'],
        'G' => ['00','00','..'],
        'H' => ['0.','00','..'],
        'I' => ['.0','0.','..'],
        'J' => ['.0','00','..'],
        'K' => ['0.','..','0.'],
        'L' => ['0.','0.','0.'],
        'M' => ['00','..','0.'],
        'N' => ['00','.0','0.'],
        'O' => ['0.','.0','0.'],
        'P' => ['00','0.','0.'],
        'Q' => ['00','00','0.'],
        'R' => ['0.','00','0.'],
        'S' => ['.0','0.','0.'],
        'T' => ['.0','00','0.'],
        'U' => ['0.','..','00'],
        'V' => ['0.','0.','00'],
        'W' => ['.0','00','.0'],
        'X' => ['00','..','00'],
        'Y' => ['00','.0','00'],
        'Z' => ['0.','.0','00'],
        ' ' => ['..','..','..'],
        '.' => ['..','00','.0'],
        '?' => ['..','0.','00'],
        '!' => ['..','00','0.'],
        ',' => ['..','0.','..']
      }

      @converter.create_word_array

      expect(@converter.file1).to eq('./data/braille.txt')
      expect(@converter.file2).to eq('./data/original_message.txt')
      expect(@converter.braille_dictionary).to eq(expected)
    end
  end

  describe '#create_word_array' do
    it 'reads a text file and creates an array of the words' do
      expected = ["0.0.0.0.0....00.0.0.00", "00.00.0..0..00.0000..0", "....0.0.0....00.0.0..."]

      expect(@converter.create_word_array).to be_an(Array)
      expect(@converter.create_word_array).to eq(expected)
    end
  end

  describe '#get_pairs' do
    it 'changes the line array from being one solid line to pairs of . and 0' do
      example_word_array = @converter.create_word_array
      expected = [["0.", "0.", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", "00"],
      ["00", ".0", "0.", "0.", ".0", "..", "00", ".0", "00", "0.", ".0"],
      ["..", "..", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", ".."]]


      expect(@converter.get_pairs(example_word_array)).to eq(expected)
    end
  end

  describe '#create_line_groups' do
    it 'creates an array of line groupings of each three lines in a braille file' do
      example_word_array = @converter.create_word_array
      example_pairs = @converter.get_pairs(example_word_array)
      expected = expected = [[["0.", "0.", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", "00"],
      ["00", ".0", "0.", "0.", ".0", "..", "00", ".0", "00", "0.", ".0"],
      ["..", "..", "0.", "0.", "0.", "..", ".0", "0.", "0.", "0.", ".."]]]

      expect(@converter.create_line_groups(example_pairs)).to eq(expected)
    end
  end

  describe '#create_line_array' do
    xit 'returns an array of lines to be converted into braille' do
      example_word_array = @converter.create_word_array
      expected = ["hello world"]

      expect(@converter.create_line_array(example_word_array,40)).to be_an(Array)
      expect(@converter.create_line_array(example_word_array,40)).to eq(expected)
    end
  end

end
