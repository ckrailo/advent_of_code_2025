#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'humanize'

puts 'Paste Rotations (empty line continues)...'
inputs = []

while (input = $stdin.gets.chomp)
  break if input.empty?

  inputs << input
end

count_of_zeroes = 0

dial = 50
puts "- The dial starts by pointing at #{dial}."
inputs.each do |input|
  if input[0] == 'R'
    dial += input[1..].to_i
  elsif input[0] == 'L'
    dial -= input[1..].to_i
  else
    puts "Invalid Input: #{input}"
  end

  dial %= 100

  count_of_zeroes += 1 if dial.zero?

  puts "- The dial is rotated #{input} to point at #{dial}."
end

puts "\nBecause the dial points at 0 a total of #{count_of_zeroes.humanize} times during this process, the password is #{count_of_zeroes}." # rubocop:disable Layout/LineLength
