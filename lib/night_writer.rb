file_array = ARGV

#collector = []
character_array = File.open(file_array[0]).each_char.map do |byte|
  #collector.push(byte)
  byte
end
p character_array
