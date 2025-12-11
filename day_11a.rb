#!/usr/bin/env ruby
# frozen_string_literal: true

puts 'Paste Device List (empty line continues)...'

device_list = {}
while (device_list_line = $stdin.gets.chomp)
  break if device_list_line.empty?

  device, device_connected_to = device_list_line.split(':').map(&:chomp)
  device_connected_to = device_connected_to.split(' ').map(&:chomp)
  device_list[device] = device_connected_to
end

def count_paths(device_list, start_device, end_device)
  count = 0
  paths = device_list.delete(start_device)

  return 1 if paths.include?(end_device)
  
  paths.each do |next_device|
    count += count_paths(device_list.dup, next_device, end_device)
  end

  count
end

puts "There are #{count_paths(device_list, 'you', 'out')} paths from 'you' to 'out'."
