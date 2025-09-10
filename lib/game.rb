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
    @player_one = player_one.new(self)
    @player_two = player_two.new(self)
  end

  def play
    @code = @player_one.make_code
    puts @code
    if @player_one.instance_of?(HumanPlayer)
      @player_two.computer_play(@code)
    else
      human_play(@player_two)
    end
  end

  # feedback methods, used for both players
  def give_feedback(guess, code)
    guess_temp = guess.dup
    code_temp = code.dup
    # resets counters for each code check
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
      # removes colors that have been counted
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

      # removes only 1 of the included color, not all
      white_index = code_temp.index(color)
      code_temp[white_index] = 'counted'
    end
  end

  def did_you_win?
    return unless @red_counter == 4

    puts 'You won!'
    true
  end

  # display methods for guesses and feedback

  def display_feedback(red_total, white_total)
    puts
    puts "Red pegs: #{red_total}"
    puts "White pegs: #{white_total}"
    puts
  end
end
