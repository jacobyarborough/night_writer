class BrailleLogic
  attr_reader :read_file,
              :write_file,
              :converter

  def initialize(file_array)
    @read_file = file_array[0]
    @write_file = file_array[1]
    @converter = BrailleConverter.new(@read_file, @write_file)
  end

  def braille_conversion_logic
    english_word_array = @converter.create_word_array
    english_line_array = @converter.create_line_array(english_word_array, 40)
    braille_line_array = @converter.create_braille_array(english_line_array)
    @converter.print_braille_to_file(braille_line_array)
    puts "Created #{@write_file} containing #{File.readlines(@write_file).join("").length} characters"
  end
end
