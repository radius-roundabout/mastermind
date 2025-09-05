# frozen_string_literal: true

def computer_play
  all_options = COLORS.repeated_permutations(4).to_a
  first_guess = ["red", "red", "orange", "orange"]
  first_guess_result = give_feedback(first_guess)
  puts first_guess_result 
  return if did_you_win? 

  all_results = all_options.to_h {|option| [option, give_feedback(option)] }

  after_first_guess = all_results.reject { |option, result| result == first_guess_result }

  for each

end


def computer_play_game
  final_computer_guess = Array.new
  colors_included = Array.new

  COLORS.each do |color|
    guess_array = Array.new(4, color)
    print_guess(guess_array)
    give_feedback(guess_array)
    @red_counter.times do
      colors_included.push(color)
    end
  end

  colors_included.each_with_index do |color, index|
    guess_array
      
  end

final_computer_guess[index] = color if @code[index] = color

end


    next unless computer_guess_array[index] = 0

    give_feedback(guess_array)
    save_red_guesses(guess_array)
  end
end

def print_guess(guess_array)
  puts "#{guess_array[0]}, #{guess_array[1]}, #{guess_array[2]}, #{guess_array[3]}"
end


