require "pry"
require_relative "file_parser"
require_relative "tree"

f = FileParser.new("/Users/ethan/Downloads/samples/input05.txt")
t = Tree.new(f.adjacency_list)
