# frozen_string_literal: true

require_relative 'player'
require_relative 'game'

# class for human player
class HumanPlayer < Player
  # codemaker method for humans
  def make_code
    puts 'You have chosen to create the code.'
    puts

    initial_instructions

    create_code_array
  end

  # codebreaker methods for human
  def take_a_turn(number)
    give_instructions(number)
    create_code_array
  end

  def give_instructions(number)
    if number.zero?
      initial_instructions
    else
      next_instructions
    end
  end

  def initial_instructions
    puts
    puts 'Please enter an array of four colors.'
    puts 'Choose from the following:'
    puts 'red, orange, yellow, green, blue, purple. '
    puts 'You may use the same color more than once.'
    puts
  end

  def next_instructions
    puts 'Please enter another guess.'
    puts
  end

  def create_code_array
    # takes comma-separated list and breaks it into an array, removing spaces
    new_code_array = gets.chomp.split(',').map(&:strip)

    return new_code_array unless array_valid?(new_code_array) == false

    create_code_array
  end

  def array_valid?(new_array)
    new_array.each do |color|
      next if Game::COLORS.include?(color)

      return false
    end
  end
end
