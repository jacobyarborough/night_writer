class BrailleConverter
  attr_reader :file1,
              :file2,
              :braille_dictionary

  def initialize(file1, file2)
    @file1 = file1
    @file2 = file2
    @braille_dictionary = braille_dict
  end

  def create_word_array
    File.read(@file1).split
  end

  def create_line_array(word_array, width)
    max_width = width
    final_result = []
    string_element = ''
    word_array.each do |word|
      if word.length > max_width
        final_result.push(string_element) unless string_element.empty?
        string_element = ''
        word.each_char do |character|
          string_element += character
          if string_element.length == max_width
            final_result.push(string_element)
            string_element = ''
          end
        end
      elsif
        if (string_element + " " + word).length <= max_width && string_element.length > 0
          string_element += (" " + word)
        else
          string_element += word
        end
      else
        final_result.push(string_element)
        string_element = word
      end
    end
    final_result.push(string_element)
    final_result
  end

  def create_braille_array(line_array)
    braille_array = []
    array_builder = []
    line_array.each do |line|
      line.split('').each do |character|
        array_builder.push(braille_dictionary[character])
      end
      braille_array.push(array_builder)
      array_builder = []
    end
    braille_array
  end

  def print_braille_to_file(braille_array)
    braille_array.each do |element|
      new_array = element.transpose
      require 'pry';binding.pry
      File.open(@file2, "a") { |f|
        f << "#{new_array[0].join('')}\n"
        f << "#{new_array[1].join('')}\n"
        f << "#{new_array[2].join('')}\n"
      }
    end
  end

  def braille_dict
    {
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
  end
end
