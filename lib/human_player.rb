# frozen_string_literal: true

require_relative 'lib/player'

# class for human player
class HumanPlayer < Player
  # def initialize(human_class, computer_class)
  #   super
  #   @human = human_class
  #   @computer = computer_class
  # end
  def choose_role
    puts 'Do you want to be the codemaker or codebreaker?'
    role = gets.chomp.toLower
    choose_role until %w[codemaker codebreaker].include?(role)
  end

  # codemaker methods for human player
  
  def 
    
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


end
