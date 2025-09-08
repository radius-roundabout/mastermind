# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'

# class for each game of mastermind
class Game
  COLORS = %w[red orange yellow green blue purple].freeze

  def initialize(player_one, player_two)
    @code = []
    @current_guess = []
    @red_counter = 0
    @white_counter = 0
    # @white_counter_array = []
    # @white_counter_array = []
    @player_one = player_one.new(self)
    @player_two = player_two.new(self)
  end

  # attr_accessor :code, :current_guess
  # attr_reader :white_counter, :red_counter

  def play
    @code = @player_one.make_code
    puts @code
    # the codebreaker player gets 12 guesses
    if @player_one.instance_of?(HumanPlayer)
      @player_two.computer_play(@code)
    else
      human_play(@player_two)
    end
  end

  def human_play(human_player)
    12.times do |number|
      @current_guess = human_player.take_a_turn(number)
      give_feedback(@current_guess)
      display_feedback(@red_counter, @white_counter)
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
  # def give_feedback(guess)
  #   # resets counters so numbers don't increase every turn
  #   @red_counter_array = Array.new(4, 0)
  #   @white_counter_array = Array.new(4, 0)
  #   code_histogram = histogram
  #   # histogram allows accurate rendering of number of colors in code
  #   # so same color isn't counted multiple times
  #   make_counter_arrays(guess, code_histogram)

  #   @white_counter = counter_total(@white_counter_array)

  #   [@red_counter, @white_counter]
  # end

  # def histogram
  #   @code.each_with_object(Hash.new(0)) do |color, histogram|
  #     histogram[color] += 1
  #   end
  # end

  # def evaluate_histogram(histogram, color, index)
  #   guess.each_with_index do |color, index|
  #   return unless @code.include?(color) && @white_counter < histogram[color]

  #     if color == @code[index]
  #       @red_counter += 1
  #     else
  #       @white_counter += 1
  #     end
  #   end
  # end
  #

  def give_feedback(guess, code)
    guess_temp = guess.dup
    code_temp = code.dup
    # resets counters for each check
    @red_counter = 0
    @white_counter = 0
    count_reds(guess_temp, code_temp)
    count_whites(guess_temp, code_temp)

    [@red_counter, @white_counter]
  end

  def count_reds(guess_temp, code_temp)
    guess_temp.each_with_index do |color, index|
      next unless color == code_temp[index]

      @red_counter += 1
      guess_temp[index] = 'counted'
      code_temp[index] = 'counted'
    end
  end

  def count_whites(guess_temp, code_temp)
    guess_temp.each_with_index do |color, index|
      next if color == 'counted'
      next unless code_temp.include?(color)

      @white_counter += 1
      guess_temp[index] = 'counted'
      code_temp[index] = 'counted'
      break if guess_temp.uniq == 'counted'
    end
  end

  # def make_counter_arrays(guess, histogram)
  #   guess.each_with_index do |color, index|
  #     # right color, right place
  #     @red_counter_array[index] = 1 if color == @code[index]
  #   end
  #   # color included, and only counted as many
  #   # times as it actually appears in code
  #   guess.each_with_index do |color, index|
  #     next if @red_counter_index == 1

  #     if @code.include?(color) && @white_counter_array[index] < histogram[color]
  #     end
  #   end

  #   def counter_total(counter)
  #     counter.reduce { |total, number| total + number }
  #   end

  def did_you_win?
    return unless @red_total == 4

    puts 'You won!'
    true
  end

  def display_feedback(red_total, white_total)
    puts
    puts "Red pegs: #{red_total}"
    puts "White pegs: #{white_total}"
    puts
  end
end
