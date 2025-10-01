# frozen_string_literal: true

# module contains text for game
module TextContent
  def role_message(message)
    {
      'choose_role' => 'Do you want to be the codemaker or codebreaker?',
      'validate_role' => 'Please enter either \"codebreaker\" or \"codemaker\"'
    }[message]
  end

  def human_play_message(message)
    {
      'code_maker' => 'You have chosen to create the code.',
      'next_guess' => 'Please enter another guess.'
    }
  end

  def choose_colors_message
    <<~HEREDOC

      Please enter an array of four colors.
      Choose from the following:red, orange, yellow, green, blue, purple.
      You may use the same color more than once.

    HEREDOC
  end
end
