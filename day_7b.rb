#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Tachyon Manifold Diagram (empty line continues)...'

tachyon_manifold = []
while (tachyon_manifold_row = $stdin.gets.chomp)
  break if tachyon_manifold_row.empty?

  tachyon_manifold << tachyon_manifold_row.chars
end

width = tachyon_manifold[0].size

# timeline_counts = []
timeline_counter = Array.new(width, 0)
# timeline_counts << timeline_counter
puts tachyon_manifold[0].join
tachyon_manifold[1][tachyon_manifold[0].index('S')] = '|'
timeline_counter[tachyon_manifold[0].index('S')] = 1
# timeline_counts << timeline_counter
puts tachyon_manifold[1].join

tachyon_manifold.each_with_index do |manifold_row, row_index|
  next if [0,1].include?(row_index)

  new_timeline_counter = Array.new(width, 0)

  manifold_row.each_with_index do |char, column_index|
    next unless tachyon_manifold[row_index - 1][column_index] == '|'

    tachyon_manifold[row_index][column_index] = '|' if char == '.'

    next unless char == '^'

    tachyon_manifold[row_index][column_index - 1] = '|'
    tachyon_manifold[row_index][column_index + 1] = '|'
  end

  tachyon_manifold[row_index].each_with_index do |char, column_index|
    next unless char == '|'

    new_timeline_counter[column_index] += timeline_counter[column_index]

    if column_index.positive? && tachyon_manifold[row_index][column_index - 1] == '^'
      new_timeline_counter[column_index] += timeline_counter[column_index - 1]
    end

    if column_index + 1 < width && tachyon_manifold[row_index][column_index + 1] == '^'
      new_timeline_counter[column_index] += timeline_counter[column_index + 1]
    end
  end

  timeline_counter = new_timeline_counter
  # timeline_counts << new_timeline_counter
  puts tachyon_manifold[row_index].join
end

number_of_timelines = timeline_counter.sum
puts "\nThe beam was split across #{number_of_timelines} timeline#{'s' if number_of_timelines.positive?}."
