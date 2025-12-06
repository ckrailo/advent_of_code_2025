#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Math Worksheet (empty line continues)...'

input_text = []
while (math_row = $stdin.gets.reverse)
  break if math_row.chomp.empty?

  input_text << math_row[1..]
end

number_sets = []
input_text[..-2].each_with_index do |input_line, line_index|
  input_line.chars.each_with_index do |char, column_index|
    number_sets[column_index] ||= []
    number_sets[column_index][line_index] = char
  end
end
puts number_sets.inspect

separated_number_sets = []
number_set = []
number_sets.each do |numbers_array|
  number_set << numbers_array unless numbers_array.all?(' ')

  if numbers_array.all?(' ')
    separated_number_sets << number_set
    number_set = []
  end
end
separated_number_sets << number_set

puts
puts separated_number_sets.inspect

math_symbols = input_text[-1].chomp.squeeze.split(' ')

answers = []
math_symbols.each_with_index do |math_symbol, index|
  numbers_to_math = []

  separated_number_sets[index].each do |numbers|
    numbers_to_math << numbers.join.chomp
  end

  math = numbers_to_math.join(math_symbol)
  answer = eval(math)
  puts "#{math} = #{answer}"
  answers << answer
end

puts "The grand total is #{answers.sum}!"
