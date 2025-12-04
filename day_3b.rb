#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Battery Banks (empty line continues)...'
banks = []

while (bank = $stdin.gets.chomp)
  break if bank.empty?

  banks << bank
end

total_joltage = 0

banks.each do |bank|
  bank_array = bank.chars.map(&:to_i)
  max_joltage = []
  needed_size = 12

  mindex = bank_array.index(bank_array[..-needed_size].max)
  slimmed_array = bank_array[mindex..]
  max_joltage << slimmed_array.shift
  needed_size -= 1

  while max_joltage.size < 12
    next_max = slimmed_array.max
    next_max_index = slimmed_array.index(slimmed_array.max)
    while slimmed_array.size - next_max_index < needed_size
      # too close to the end, find the next best value
      next_max = slimmed_array.max_by { |x| x < next_max ? x : 0 }
      next_max_index = slimmed_array.index(next_max)
    end

    slimmed_array.shift(next_max_index)
    max_joltage << slimmed_array.shift
    needed_size -= 1
  end

  total_joltage += max_joltage.join.to_i
  puts "- #{bank} max joltage is #{max_joltage.join}"
end

puts "\nTotal max joltage is #{total_joltage}."
