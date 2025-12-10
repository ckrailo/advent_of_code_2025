#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Red Tile Coordinates (empty line continues)...'

red_tiles = []
while (red_tile = $stdin.gets.chomp)
  break if red_tile.empty?

  red_tiles << red_tile.split(',').map(&:to_i)
end

red_tiles.sort!

largest_area = 0
red_tiles.each do |red_tile1|
  red_tiles.each do |red_tile2|
    next if red_tile1 == red_tile2

    red_x_coords = [red_tile1[0], red_tile2[0]]
    red_y_coords = [red_tile1[1], red_tile2[1]]
    area = (red_x_coords.max - red_x_coords.min + 1) * (red_y_coords.max - red_y_coords.min + 1)
    largest_area = area if area > largest_area
  end
end

puts "The largest area of any rectangle you can make is #{largest_area}."
