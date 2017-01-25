require "pry"

require "./src/file_parser"
require "./src/tree_controller.rb"
require "./src/tree_navigator.rb"

path = ARGV[0]

if path && File.exist?(path)
else
  puts "You must specify a file path as a command-line argument"
end
