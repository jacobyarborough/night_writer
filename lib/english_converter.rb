class EnglishConverter

  attr_reader :file1,
              :file2,
              :braille_dictionary

  def initialize(file1, file2)
    @file1 = file1
    @file2 = file2
    @braille_dictionary = braille_dict
  end

  def create_word_array
    braille_string = File.read(@file1).split
  end

  def get_pairs(word_array)
    paired_array = []
    line_array = []
    word_array.each do |line|
      substring = ''
      line.split('').each do |character|
        if substring.length == 2
          line_array.push(substring)
          substring = ''
          substring += character
        else
          substring += character
        end
      end
      line_array.push(substring)
      paired_array.push(line_array)
      line_array = []
    end
    paired_array
  end

  def create_line_groups(pairs_array)
    line_group_array = []
    line_group = []
    pairs_array.each do |line|
      if line_group.length == 3
        line_group_array.push(line_group)
        line_group = []
        line_group.push(line)
      else
        line_group.push(line)
      end
    end
    line_group_array.push(line_group)
    line_group_array
  end

  def transpose(line_group_array)
    line_group_array.map do |line_group|
      line_group.transpose
    end
  end

  def create_english_array(transposed_braille_array)
    english_character_array = []
    english_word_array = []
    transposed_braille_array.each do |braille_line|
      braille_line.each do |braille_character|
        english_character_array.push(braille_dict.key(braille_character))
      end
    end
    word_string = ''
    english_character_array.each do |character|
      if character == ' '
        english_word_array.push(word_string)
        word_string = ''
      else
        word_string += character
      end
    end
    english_word_array.push(word_string)
    english_word_array
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
      ' ' => ['..','..','..'],
      '.' => ['..','00','.0'],
      '?' => ['..','0.','00'],
      '!' => ['..','00','0.'],
      ',' => ['..','0.','..']
    }
  end
end
