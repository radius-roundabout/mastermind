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
  def computer_play(real_code)
    all_code_options = Game::COLORS.repeated_permutation(4).to_a
    guess = %w[red red orange orange]
    print guess
    guess_result = @game.give_feedback(guess, real_code)
    print guess_result
    return if @game.did_you_win?

    keep_guessing(all_code_options, guess, guess_result)
  end

  def evaluate_guesses(code_array, guess, guess_result)
    code_array.each_with_index do |code_option, index|
      # assumes guess is the code, compares every code option to guess
      next unless @game.give_feedback(code_option, guess) != guess_result

      code_array.delete_at(index)
    end
  end

  def keep_guessing(code_array, guess, guess_result)
    until code_array.length == 1
      evaluate_guesses(code_array, guess, guess_result)
      guess = code_array[0]
      print guess
    end
    puts 'Computer won!'
  end
end
