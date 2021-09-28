class EnglishLogic
  attr_reader :read_file,
              :write_file,
              :converter

  def initialize(file_array)
    @read_file = file_array[0]
    @write_file = file_array[1]
    @converter = EnglishConverter.new(@read_file, @write_file)
  end

  def english_conversion_logic
    braille_word_array = @converter.create_word_array
    braille_pairs = @converter.get_pairs(braille_word_array)
    braille_line_groups = @converter.create_line_groups(braille_pairs)
    braille_transposed_array = @converter.transpose(braille_line_groups)
    english_array = @converter.create_english_array(braille_transposed_array)
    english_lines = @converter.create_line_array(english_array, 80)
    @converter.print_english_to_file(english_lines)

    puts "Created #{@write_file} containing #{english_lines.join('').length} characters"
  end
end
