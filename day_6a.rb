#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Math Worksheet (empty line continues)...'

math_columns = []
while (math_row = $stdin.gets.chomp)
  break if math_row.empty?

  math_row = math_row.squeeze(' ').split(' ')
  math_columns << math_row
end

math_columns[..-2].each_with_index do |math_row, index|
  math_columns[index] = math_row.map(&:to_i)
end

answers = []
math_columns[0].size.times do |column_index|
  answers << eval(math_columns[..-2].map do |row|
    row[column_index-1]
  end.join(math_columns[-1][column_index-1]))
end

puts "The grand total is #{answers.sum}!"
