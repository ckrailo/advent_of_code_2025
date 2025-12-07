#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Tachyon Manifold Diagram (empty line continues)...'

tachyon_manifold = []
while (tachyon_manifold_row = $stdin.gets.chomp)
  break if tachyon_manifold_row.empty?

  tachyon_manifold << tachyon_manifold_row.chars
end

puts tachyon_manifold[0].join
tachyon_manifold[1][tachyon_manifold[0].index('S')] = '|'
puts tachyon_manifold[1].join

number_of_splits = 0

tachyon_manifold.each_with_index do |manifold_row, row_index|
  next if [0,1].include?(row_index)

  manifold_row.each_with_index do |char, column_index|
    next unless tachyon_manifold[row_index - 1][column_index] == '|'

    tachyon_manifold[row_index][column_index] = '|' if char == '.'

    next unless char == '^'

    number_of_splits += 1
    tachyon_manifold[row_index][column_index - 1] = '|'
    tachyon_manifold[row_index][column_index + 1] = '|'
  end
  puts tachyon_manifold[row_index].join
end

puts "\nThe beam was split #{number_of_splits} time#{'s' if number_of_splits.positive?}."
