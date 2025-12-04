#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Rolls of Paper Diagram (empty line continues)...'

rolls = []

while (rolls_row = $stdin.gets.chomp)
  break if rolls_row.empty?

  rolls << rolls_row.chars
end

total_accessible_rolls = 0

accessible_rolls = 0
loop do
  accessible_rolls = 0
  rolls.each_index do |x|
    rolls[x].each_index do |y|
      unless rolls[x][y] == '.'
        neighbor_count = 0

        if x > 0
          # check row above
          if y > 0
            # check top left
            neighbor_count += 1 if ['x','@'].include?(rolls[x-1][y-1])
          end
          neighbor_count += 1 if ['x','@'].include?(rolls[x-1][y])
          if y < rolls[x].size - 1
            # check top right
            neighbor_count += 1 if ['x','@'].include?(rolls[x-1][y+1])
          end
        end

        # check left neighbor
        if y > 0
          neighbor_count += 1 if ['x','@'].include?(rolls[x][y-1])
        end

        # check right neighbor
        if y < rolls[x].size - 1
          neighbor_count += 1 if ['x','@'].include?(rolls[x][y+1])
        end

        if x < rolls.size - 1
          # check row below
          if y > 0
            # check bottop left
            neighbor_count += 1 if ['x','@'].include?(rolls[x+1][y-1])
          end
          neighbor_count += 1 if ['x','@'].include?(rolls[x+1][y])
          if y < rolls[x].size - 1
            # check bottom right
            neighbor_count += 1 if ['x','@'].include?(rolls[x+1][y+1])
          end
        end

        if neighbor_count < 4
          rolls[x][y] = 'x'
          accessible_rolls += 1
        end
      end
    end
  end

  puts "\nRemove #{accessible_rolls} of paper:"
  rolls.each do |row|
    puts row.join
  end

  rolls.each_index do |x|
    rolls[x].each_index do |y|
      rolls[x][y] = '.' if rolls[x][y] == 'x'
    end
  end

  total_accessible_rolls += accessible_rolls

  break if accessible_rolls.zero?
end

puts "\nA total of #{total_accessible_rolls} rolls of paper can be removed."
