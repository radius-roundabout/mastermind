# frozen_string_literal: true

# class for each game of mastermind
class Game
  COLORS = %w[red orange yellow green blue purple].freeze

  def initialize
    @code = []
    @red_counter = 0
    @white_counter = 0
    @current_guess = []
  end

  attr_accessor :code, :current_guess
  attr_reader :white_counter, :red_counter

  # computer code methods
  def play_with_computer_code
    12.times do |number|
      if number.zero?
        ask_for_first_guess
      else
        ask_for_next_guesses
      end
      human_turn
      break if did_you_win?
    end
  end

  def human_turn
    random_generator(@code)
    ask_for_human_guess
    give_feedback(@current_guess)
    display_feedback
  end

  def random_generator(new_code)
    4.times do
      new_code.push(COLORS.sample)
    end

    new_code
  end

  def ask_for_first_guess
    puts
    puts 'Please enter an array of four colors.'
    puts 'Choose from the following:'
    puts 'red, orange, yellow, green, blue, purple. '
    puts 'You may use the same color more than once.'
    puts
  end

  def ask_for_next_guesses
    puts 'Please enter another guess.'
    puts
  end

  def ask_for_human_input
    # takes comma-separated list and breaks it into an array, removing spaces
    @current_guess = gets.chomp.split(',').map(&:strip)

    return unless guess_valid? == false

    ask_for_human_input
  end

  def guess_valid?
    @current_guess.each do |color|
      next if COLORS.include?(color)

      return false
    end
  end

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
    return unless red_counter == 4

    puts 'You won!'
    true
  end

  def display_feedback
    puts
    puts "Red pegs: #{red_counter}"
    puts "White pegs: #{white_counter}"
    puts
  end
end
