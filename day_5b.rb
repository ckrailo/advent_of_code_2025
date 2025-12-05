#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Ingredients Database (empty line continues)...'

ranges = []
while (ranges_row = $stdin.gets.chomp)
  break if ranges_row.empty?

  range_start, range_end = ranges_row.split('-').map(&:to_i)
  ranges << (range_start..range_end)
end

puts "Checking #{ranges.size} ranges..."
has_overlap = nil
loop do
  has_overlap = false
  ranges_dup = ranges.dup
  ranges_dup.each_with_index do |x_range, x_index|
    next if has_overlap

    ranges_dup.each_with_index do |y_range, y_index|
      next if has_overlap || x_index == y_index
      next unless x_range.cover?(y_range.min) || x_range.cover?(y_range.max)

      puts "#{x_range} overlaps with #{y_range}"
      has_overlap = true
      ranges[x_index] = ([x_range.min,y_range.min].min..[x_range.max,y_range.max].max)
      ranges.delete_at(y_index)
    end
  end
  break unless has_overlap
end

total_count = ranges.map(&:size).sum

puts "\n#{total_count} ingredient IDs are fresh."
