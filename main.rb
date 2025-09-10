# frozen_string_literal: true

require_relative 'lib/game'
require 'pry-byebug'

answer = ''

new_game = Game.new(HumanPlayer, ComputerPlayer)

until answer == 'N'
  new_game.play
  puts
  puts 'Do you want to play again? Y/N'
  answer = gets.chomp.upcase

  until %w[Y N].include?(answer)
    puts
    puts 'Please enter Y or N. Do you want to play again?'
  end
end
