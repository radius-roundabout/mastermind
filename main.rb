# frozen_string_literal: true

require_relative 'lib/game'

new_game = Game.new

new_game.play_with_computer_code

until answer != 'Y' || answer != 'N'
  puts 'Do you want to play again? Y/N'
  answer = gets.chomp
end

new_game.play_with_computer_code until answer == 'N'
