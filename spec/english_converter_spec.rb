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
      expect(@converter.get_pairs(example_word_array)).to be_an(Array)
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
      expect(@converter.create_line_groups(example_pairs)).to be_an(Array)
    end
  end

  describe '#transpose' do
    it 'tansposes each line in the line_groups array' do
      example_word_array = @converter.create_word_array
      example_pairs = @converter.get_pairs(example_word_array)
      example_line_groups = @converter.create_line_groups(example_pairs)
      expected = [[["0.", "00", ".."],
      ["0.", ".0", ".."],
      ["0.", "0.", "0."],
      ["0.", "0.", "0."],
      ["0.", ".0", "0."],
      ["..", "..", ".."],
      [".0", "00", ".0"],
      ["0.", ".0", "0."],
      ["0.", "00", "0."],
      ["0.", "0.", "0."],
      ["00", ".0", ".."]]]

      expect(@converter.transpose(example_line_groups)).to eq(expected)
      expect(@converter.transpose(example_line_groups)).to be_an(Array)
    end
  end

  describe '#create_english_array' do
    it 'creates a string of english characters from the transposed braille array' do
      example_word_array = @converter.create_word_array
      example_pairs = @converter.get_pairs(example_word_array)
      example_line_groups = @converter.create_line_groups(example_pairs)
      example_transpose_array = @converter.transpose(example_line_groups)

      expect(@converter.create_english_array(example_transpose_array)).to eq(["hello", "world"])
    end
  end

  describe '#create_line_array' do
    it 'returns an array of lines to be converted into braille' do
      example_word_array = @converter.create_word_array
      example_pairs = @converter.get_pairs(example_word_array)
      example_line_groups = @converter.create_line_groups(example_pairs)
      example_transpose_array = @converter.transpose(example_line_groups)
      example_english_array = @converter.create_english_array(example_transpose_array)
      expected = ["hello world"]

      expect(@converter.create_line_array(example_english_array,80)).to be_an(Array)
      expect(@converter.create_line_array(example_english_array,80)).to eq(expected)
    end
  end

  describe '#print_english_to_file' do
    it 'prints the english to a file' do
      File.write(@file2,'')
      example_word_array = @converter.create_word_array
      example_pairs = @converter.get_pairs(example_word_array)
      example_line_groups = @converter.create_line_groups(example_pairs)
      example_transpose_array = @converter.transpose(example_line_groups)
      example_english_array = @converter.create_english_array(example_transpose_array)
      example_english = @converter.create_line_array(example_english_array,80)
      @converter.print_english_to_file(example_english)
      expected = ["hello world\n"]

      expect(File.readlines(@file2)).to be_an(Array)
      expect(File.readlines(@file2)).to eq(expected)
    end
  end
end
