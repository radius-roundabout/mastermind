# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'

# class for each game of mastermind
class Game
  COLORS = %w[red orange yellow green blue purple].freeze

  def initialize(human_player, computer_player)
    @code = []
    @human_player = human_player.new(self)
    @computer_player = computer_player.new(self)
  end

  def choose_role
    puts 'Do you want to be the codemaker or codebreaker?'
    role = gets.chomp.to_s.downcase

    if %w[codemaker codebreaker].include?(role)
      role
    else
      puts 'Please enter either \"codebreaker\" or \"codemaker\"'
      choose_role
    end
  end

  def play
    human_role = choose_role

    if human_role == 'codemaker'
      @code = @human_player.make_code
      puts @code
      @computer_player.computer_play(@code)
    else
      @code = @computer_player.make_code
      puts @code
      @human_player.human_play(@code)
    end
  end
end
