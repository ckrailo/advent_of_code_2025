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
total_count_of_passing_zeroes = 0

dial = 50
puts "- The dial starts by pointing at #{dial}."
inputs.each do |input|
  started_at_zero = dial.zero?

  if input[0] == 'R'
    dial += input[1..].to_i
  elsif input[0] == 'L'
    dial -= input[1..].to_i
  else
    puts "Invalid Input: #{input}"
  end

  instance_count_of_passing_zeroes = dial.abs / 100
  instance_count_of_passing_zeroes += 1 if dial.negative? && !started_at_zero
  dial %= 100

  if dial.zero?
    count_of_zeroes += 1
    instance_count_of_passing_zeroes -= 1
  end

  total_count_of_passing_zeroes += instance_count_of_passing_zeroes if instance_count_of_passing_zeroes.positive?

  print "- The dial is rotated #{input} to point at #{dial}"
  if instance_count_of_passing_zeroes.positive?
    puts "; during this rotation, it points at 0 #{instance_count_of_passing_zeroes.humanize} time#{'s' if instance_count_of_passing_zeroes > 1}." # rubocop:disable Layout/LineLength
  else
    puts '.'
  end
end

puts "\nBecause the dial points at 0 #{count_of_zeroes.humanize} time#{'s' if count_of_zeroes > 1} during this process, plus #{total_count_of_passing_zeroes.humanize} more time#{'s' if total_count_of_passing_zeroes > 1} during a rotation, the password is #{count_of_zeroes + total_count_of_passing_zeroes}." # rubocop:disable Layout/LineLength
