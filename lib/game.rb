# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'
require_relative 'text_content'

# class for each game of mastermind
class Game
  attr_reader :code, :human_player, :computer_player

  include TextContent

  def initialize(human_player, computer_player)
    @human_player = human_player.new(self)
    @computer_player = computer_player.new(self)
  end

  def choose_role
    puts role_message('choose_role')
    role = gets.chomp.to_s.downcase

    puts role_message('validate_role') until %w[codemaker codebreaker].include?(role)

    role
  end

  def assign_role(maker, breaker)
    @code = maker.make_code
    breaker.break_code(code)
  end

  def play
    human_role = choose_role

    human_role == 'codemaker' ? assign_role(human_player, computer_player) : assign_role(computer_player, human_player)
  end
end
