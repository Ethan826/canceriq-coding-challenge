class FileParser

  attr_reader :num_edges, :adjacency_list, :operations

  def initialize(path)
    process_file(path)
  end

  def num_operations
    operations.length
  end

  private

  def process_file(path)
    File.open(path, "r") do |f|
      file_iterator = f.each_line
      make_num_edges(file_iterator)
      make_adjacency_list(file_iterator)
      make_operations(file_iterator)
    end
  end

  def make_num_edges(file_iterator)
    @num_edges = file_iterator.next.chomp.to_i
  end

  def make_adjacency_list(file_iterator)
    @adjacency_list = Array.new(num_edges) { [] }
    line = file_iterator.next.chomp
    loop do
      add_to_adjacency_list(line)
      line = file_iterator.next.chomp
      break unless line =~ /^\d+ \d+$/
    end
  end

  def add_to_adjacency_list(line)
    connected_nodes = line.split(" ").map { |e| e.to_i.pred }
    adjacency_list[connected_nodes.first] << connected_nodes.last
    adjacency_list[connected_nodes.last] << connected_nodes.first
  end

  def make_operations(file_iterator)
    @operations = []
    file_iterator.each do |line|
      line = line.chomp.split(" ")
      @operations << if line.first == "add"
                       Tree::Add.new(line[1].to_i, line[2].to_i)
                     else
                       Tree::Max.new(line[1].to_i, line[2].to_i)
      end
    end
  end

end
