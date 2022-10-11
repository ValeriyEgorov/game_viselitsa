current_path = File.dirname(__FILE__)

require current_path + "/lib/result_printer.rb"
require current_path + "/lib/game.rb"
require current_path + "/lib/word_reader.rb"

VERSION = 'Игра виселица, версия 5.'

reader = WordReader.new

word = reader.read_from_file(current_path + '/data/words.txt')

game = Game.new(word)
game.version = VERSION

printer = ResultPrinter.new

while game.in_progress? do

	printer.print_status(game)

	game.ask_next_letter
end

printer.print_status(game)

