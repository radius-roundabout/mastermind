# frozen_string_literal: true

require_relative 'player'
require_relative 'game'

# this is the computer player class
class ComputerPlayer < Player
  # codemaker method for computer
  def make_code
    new_code = []
    4.times do
      new_code.push(Game::COLORS.sample)
    end
    new_code
  end

  # codebreaker methods for computer
  def break_code(real_code)
    all_code_options = Game::COLORS.repeated_permutation(4).to_a
    # all_code_options = [%w[red red red red], %w[red red red orange], %w[green blue red purple],
    #                     %w[orange red yellow green], %w[red yellow orange blue]]
    first_guess = %w[red red orange orange]
    first_guess_result = submit_a_guess(first_guess, real_code)

    filtered_array = filter(all_code_options, first_guess, first_guess_result)

    keep_guessing(filtered_array, real_code)
  end

  def submit_a_guess(guess, real_code)
    display_guess(guess)
    guess_result = give_feedback(guess, real_code)
    display_feedback(guess_result[0], guess_result[1])
    guess_result
  end

  def keep_guessing(filtered_array, real_code)
    # This strategy produces a win in an average of 5 moves
    15.times do
      guess = filtered_array[0]
      guess_result = submit_a_guess(guess, real_code)
      # if the computer's guess is right but it hasn't finished filtering
      break if did_computer_win?(guess_result)

      filtered_array = filter(filtered_array, guess, guess_result)
      # checks answer when filtered array only has 1 guess in it
      break if final_answer_correct?(filtered_array, real_code)
    end
  end

  def filter(array, guess, guess_result)
    # compares all possible codes to the current guess, selects all that would return the same result
    # if they were the guess instead
    # It is hugely inefficient to have this run through the whole array on every guess
    array.filter { |code_option| give_feedback(code_option, guess) == guess_result }
  end

  def final_answer_correct?(filtered_array, real_code)
    return unless filtered_array.length == 1

    final_answer = submit_a_guess(filtered_array.flatten, real_code)
    did_computer_win?(final_answer)
  end

  def did_computer_win?(array)
    return unless array[0] == 4

    puts
    puts 'Computer won!'
    puts

    true
  end
end
