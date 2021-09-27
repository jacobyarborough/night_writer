file_array = ARGV

braille_dictionary = {
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

word_array = File.read(file_array[0]).split

max_width = 40
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
  elsif (string_element + " " + word).length <= max_width
    string_element += (" " + word)
  else
    final_result.push(string_element)
    string_element = word
  end
end
final_result.push(string_element)

braille_array = []
array_builder = []
final_result.each do |line|
  line.split('').each do |character|
    array_builder.push(braille_dictionary[character])
  end
  braille_array.push(array_builder)
  array_builder = []
end

braille_array.each do |element|
  new_array = element.transpose
  File.open(file_array[1], "a") { |f|
    f << "#{new_array[0].join('')}\n"
    f << "#{new_array[1].join('')}\n"
    f << "#{new_array[2].join('')}\n"
  }
end

print "Created #{file_array[1]} containing #{file_array[1].length} characters"
