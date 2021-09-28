require './lib/english_converter'
require './lib/english_logic'
file_array = ARGV

translator = EnglishLogic.new(file_array)

translator.english_conversion_logic
