#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Ingredients Database (empty line continues)...'

ranges = []
while (ranges_row = $stdin.gets.chomp)
  break if ranges_row.empty?

  range_start, range_end = ranges_row.split('-').map(&:to_i)
  ranges << (range_start..range_end)
end

ingredients = []
while (ingredient_id = $stdin.gets.chomp)
  break if ingredient_id.empty?

  ingredients << ingredient_id.to_i
end

fresh_count = 0

ingredients.each do |ingredient_id|
  ranges.each do |range|
    puts "#{range.inspect}.include?(#{ingredient_id}) = #{range.include?(ingredient_id)}"
    if range.include? ingredient_id
      fresh_count += 1
      break
    end
  end
end

puts "\n#{fresh_count} of the ingredients are fresh."