# frozen_string_literal: true

require_relative 'player'
require_relative 'game'
require_relative 'text_content'

# class for human player
class HumanPlayer < Player
  # codemaker method for humans
  def make_code
    human_play_message('code_maker')
    choose_colors_message
    create_code_array
  end

  # codebreaker method for human
  def break_code(real_code)
    # the codebreaker player gets 12 guesses
    12.times do |number|
      current_guess = take_a_turn(number)
      give_feedback(current_guess, real_code)
      display_feedback(@red_counter, @white_counter)
      break if did_you_win?
    end
  end

  def take_a_turn(number)
    give_instructions(number)
    create_code_array
  end

  def give_instructions(number)
    if number.zero?
      choose_colors_message
    else
      human_play_message('next_guess')
    end
  end

  def create_code_array
    # takes comma-separated list and breaks it into an array, removing spaces
    new_code_array = gets.chomp.split(',').map(&:strip)

    return new_code_array if array_valid?(new_code_array)

    create_code_array
  end

  def array_valid?(array)
    array.each do |color|
      next if Game::COLORS.include?(color)

      return false
    end
  end
end
