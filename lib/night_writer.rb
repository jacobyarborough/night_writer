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

character_array = File.open(file_array[0]).each_char.map do |byte|
  byte
end

character_array.delete("\n")

braille_array_line1 = []
braille_array_line2 = []
braille_array_line3 = []
character_array.each do |character|
  braille_array_line1.push(braille_dictionary[character][0])
  braille_array_line2.push(braille_dictionary[character][1])
  braille_array_line3.push(braille_dictionary[character][2])
end

braille_hash = {
  braille_line1: braille_array_line1,
  braille_line2: braille_array_line2,
  braille_line3: braille_array_line3
}

File.open('braille.txt', "w") do |f|
  f << "#{braille_hash[:braille_line1].join("")}\n"
  f << "#{braille_hash[:braille_line2].join("")}\n"
  f << "#{braille_hash[:braille_line3].join("")}\n"
end

puts "Created #{file_array[1]} containing #{character_array.length} characters"
