# frozen_string_literal: true

COLORS = %w[red orange yellow green blue purple].freeze

def computer_play
  all_options = COLORS.repeated_permutation(4).to_a
  guess = %w[red red orange orange]
  guess_result = give_feedback(guess)
  puts guess_result
  return if did_you_win?

  options_with_results = []
  all_options.each { |option| options_with_results.push([option, give_feedback(option)]) }

  keep_guessing(options_with_results, guess_result)
end

def keep_guessing(array, guess_result)
  array.each do |option|
    puts option
    array.delete(option) if option[1] == guess_result
    return array if array.length == 1

    guess_result = array[1][1]
  end

  puts 'Computer won!'
end

def give_feedback(guess)
  # resets counters so numbers don't increase every turn
  @red_counter = 0
  @white_counter_array = Array.new(4, 0)
  code_histogram = histogram
  # histogram allows accurate rendering of number of colors in code
  # so same color isn't counted multiple times
  make_counter_array(guess, code_histogram)

  @white_counter = counter_total(@white_counter_array)

  [@red_counter, @white_counter]
end

def histogram
  @code.each_with_object(Hash.new(0)) do |color, histogram|
    histogram[color] += 1
  end
end

def make_counter_array(guess, histogram)
  guess.each_with_index do |color, index|
    # right color, right place
    if color == @code[index]
      @red_counter += 1
      next
    # color included, and only counted as many
    # times as it actually appears in code
    elsif @code.include?(color) && @white_counter_array[index] < histogram[color]
      @white_counter_array[index] += 1
    end
  end
end

def counter_total(counter)
  counter.reduce { |total, number| total + number }
end

def did_you_win?
  return unless @red_total == 4

  puts 'You won!'
  true
end
