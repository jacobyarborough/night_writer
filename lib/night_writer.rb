require './lib/braille_converter'
require './lib/braille_logic'
file_array = ARGV

translator = BrailleLogic.new(file_array)

translator.braille_conversion_logic
