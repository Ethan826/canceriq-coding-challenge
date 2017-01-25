require "pry"
require "set"

class FileParser

  Add = Struct.new(:node, :value)
  Max = Struct.new(:start_node, :end_node)

  attr_reader :num_edges, :adjacency_list, :num_operations, :operations

  def initialize(path)
    File.open(path, "r") do |f|
      file_iterator = f.each_line
      @num_edges = file_iterator.next.chomp.to_i
      @operations = []
      @adjacency_list = Array.new(num_edges) { [].to_set }
      line = file_iterator.next.chomp
      loop do # Using each would require rewinding once the predicate is false
        add_to_adjacency_list(line)
        line = file_iterator.next.chomp
        break unless line =~ /^\d+ \d+$/
      end
      @num_operations = line.chomp.to_i
      file_iterator.each do |line|
        line = line.chomp.split(" ")
        @operations << if line.first == "add"
          Add.new(line[1].to_i, line[2].to_i)
        else
          Max.new(line[1].to_i, line[2].to_i)
        end
      end
    end
  end

  private

  def add_to_adjacency_list(line)
    connected_nodes = line.split(" ").map { |e| e.to_i.pred }
    adjacency_list[connected_nodes.first] << connected_nodes.last
    adjacency_list[connected_nodes.last] << connected_nodes.first
  end

end
