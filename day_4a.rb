#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Rolls of Paper Diagram (empty line continues)...'

rolls = []

while (rolls_row = $stdin.gets.chomp)
  break if rolls_row.empty?

  rolls << rolls_row.chars
end

accessible_rolls = 0

rolls.each_index do |x|
  rolls[x].each_index do |y|
    if rolls[x][y] == '.'
      print '.'
    else
      neighbor_count = 0

      if x > 0
        # check row above
        if y > 0
          # check top left
          neighbor_count += 1 if rolls[x-1][y-1] == '@'
        end
        neighbor_count += 1 if rolls[x-1][y] == '@'
        if y < rolls[x].size - 1
          # check top right
          neighbor_count += 1 if rolls[x-1][y+1] == '@'
        end
      end

      # check left neighbor
      if y > 0
        neighbor_count += 1 if rolls[x][y-1] == '@'
      end

      # check right neighbor
      if y < rolls[x].size - 1
        neighbor_count += 1 if rolls[x][y+1] == '@'
      end

      if x < rolls.size - 1
        # check row below
        if y > 0
          # check bottop left
          neighbor_count += 1 if rolls[x+1][y-1] == '@'
        end
        neighbor_count += 1 if rolls[x+1][y] == '@'
        if y < rolls[x].size - 1
          # check bottom right
          neighbor_count += 1 if rolls[x+1][y+1] == '@'
        end
      end

      if neighbor_count < 4
        print 'x'
        accessible_rolls += 1
      else
        print '@'
      end
    end
  end
  puts
end

puts "\nThere are #{accessible_rolls} rolls of paper that can be accessed by a forklift (marked with x)."
