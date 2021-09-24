file_array = ARGV

character_array = File.open(file_array[0]).each_char.map do |byte|
  byte
end

File.write(file_array[1], character_array)

puts "Created #{file_array[1]} containing #{character_array.length} characters"
