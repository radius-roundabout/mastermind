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
end
