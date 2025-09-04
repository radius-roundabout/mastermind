# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'

# class for each game of mastermind
class Game
  COLORS = %w[red orange yellow green blue purple].freeze

  def initialize(player_one, player_two)
    @code = []
    @red_counter = 0
    @white_counter = 0
    @current_guess = []
    @player_one = player_one.new(self)
    @player_two = player_two.new(self)
  end

  # attr_accessor :code, :current_guess
  # attr_reader :white_counter, :red_counter

  def play
    @code = @player_one.make_code
    # the codebreaker player gets 12 guesses
    12.times do |number|
      @current_guess = @player_two.take_a_turn(number)
      puts @current_guess
      give_feedback(@current_guess)
      display_feedback
      break if did_you_win?
    end
  end

  # # computer code methods
  # def play_with_computer_code
  #   12.times do |number|
  #     if number.zero?
  #       ask_for_first_guess
  #     else
  #       ask_for_next_guesses
  #     end
  #     human_turn
  #     break if did_you_win?
  #   end
  # end

  # def human_turn
  #   random_generator(@code)
  #   ask_for_human_guess
  #   give_feedback(@current_guess)
  #   display_feedback
  # end

  # methods for all game-play
  def give_feedback(guess)
    guess.each_with_index do |color, index|
      # color is in correct space
      if color == @code[index]
        @red_counter += 1
        next
      # color is anywhere in code
      elsif @code.include?(color)
        @white_counter += 1
      end
    end
  end

  def did_you_win?
    return unless @red_counter == 4

    puts 'You won!'
    true
  end

  def display_feedback
    puts
    puts "Red pegs: #{@red_counter}"
    puts "White pegs: #{@white_counter}"
    puts
  end
end
