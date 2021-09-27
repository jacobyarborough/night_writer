require 'rspec'
require './lib/braille_converter'
describe BrailleConverter do
  describe '#initialize' do
    it 'creates an instance of BrailleConverter' do
      file1 = './data/message.txt'
      file2 = './data/braille.txt'
      converter = BrailleConverter.new(file1,file2)
      require 'pry';binding.pry
      expect(converter).to be_an_instance_of(BrailleConverter)
    end
  end
end
