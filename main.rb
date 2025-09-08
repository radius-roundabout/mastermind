# frozen_string_literal: true

require_relative 'lib/game'
require 'pry-byebug'

def choose_role
  # binding.pry
  puts 'Do you want to be the codemaker or codebreaker?'
  role = gets.chomp.to_s.downcase

  if %w[codemaker codebreaker].include?(role)
    role
  else
    puts 'Please enter either \"codebreaker\" or \"codemaker\"'
    choose_role
  end
end

my_role = choose_role
new_game = Game.new(HumanPlayer, ComputerPlayer) if my_role == 'codemaker'
new_game = Game.new(ComputerPlayer, HumanPlayer) if my_role == 'codebreaker'

answer = ''

until answer == 'N'
  new_game.play

  until %w[Y N].include?(answer)
    puts 'Do you want to play again? Y/N'
    answer = gets.chomp
  end
end
