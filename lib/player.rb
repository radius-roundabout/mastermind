# frozen_string_literal: true

# player superclass
class Player
  def initialize(game)
    @game = game
    @red_counter = 0
    @white_counter = 0
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

  def display_guess(guess)
    puts
    puts "Computer guesses #{guess[0]}, #{guess[1]}, #{guess[2]}, #{guess[3]}"
  end

  def display_feedback(red_total, white_total)
    puts
    puts "Red pegs: #{red_total}"
    puts "White pegs: #{white_total}"
  end
end
