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

  max_joltage = bank_array.max
  if (bank_array.index(max_joltage) == bank_array.size - 1)
    second_max_joltage = bank_array[0..-2].max
    bank_max_joltage = "#{second_max_joltage}#{max_joltage}".to_i
    total_joltage += bank_max_joltage
    puts "- #{bank} max joltage is #{bank_max_joltage}"
  else
    second_max_joltage = bank_array[bank_array.index(max_joltage) + 1..].max
    bank_max_joltage = "#{max_joltage}#{second_max_joltage}".to_i
    total_joltage += bank_max_joltage
    puts "- #{bank} max joltage is #{bank_max_joltage}"
  end
end

puts "\nTotal max joltage is #{total_joltage}."
