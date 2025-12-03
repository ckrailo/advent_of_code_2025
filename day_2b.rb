#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'bigdecimal'
require 'humanize'

puts 'Paste ID Ranges ...'

invalid_ids_added = 0

# Example Input: 11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124 # rubocop:disable Metrics/LineLength
input = $stdin.gets.chomp

puts

input.split(',').each do |input_range|
  range_start, range_end = input_range.split('-').map(&:to_i)

  invalid_ids = []

  (range_start..range_end).each do |id|
    id_s = id.to_s
    if id_s.size > 1
      added = false
      (0..(id_s.size / 2 - 1)).each do |chunk_max|
        if !added && id_s == id_s.scan(id_s[0..chunk_max]).join
          invalid_ids << id_s
          invalid_ids_added += id
          added = true
        end
      end
    end
  end

  print "- #{range_start}-#{range_end}"

  if invalid_ids.empty?
    puts ' contains no invalid IDs.'
  else
    puts " has #{invalid_ids.size.humanize} invalid ID#{'s' if invalid_ids.size > 1}, #{invalid_ids.join(' and ')}."
  end
end

puts "\nAdding up all the invalid IDs produces #{invalid_ids_added}."
