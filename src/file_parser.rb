class FileParser

  attr_reader :num_edges, :adjacency_list, :operations

  # @param path [String] the path for the input file
  def initialize(path)
    process_file(path)
  end

  # The number of operations that will be performed. Could be omitted as it
  # is only used in the specs
  #
  # @return [Int]
  def num_operations
    operations.length
  end

  private

  # Handles opening the file and calling helper functions to process it.
  #
  # @param path [String] the path for the input file
  def process_file(path)
    File.open(path, "r") do |f|
      file_iterator = f.each_line
      make_num_edges(file_iterator)
      make_adjacency_list(file_iterator)
      make_operations(file_iterator)
    end
  end

  # Sets the instance variable @num_edges by processing the first line of the
  # input file.
  #
  # @param file_iterator [Enumerator] the enumerator from calling #each_line on
  #   the file, pointing at the beginning of the file
  def make_num_edges(file_iterator)
    @num_edges = file_iterator.next.chomp.to_i
  end

  # Sets the instance variable @adjacency_list by taking from the enumerator
  # until it no longer matches the pattern of two digits on a line.
  #
  # @param file_iterator [Enumerator] the enumerator from calling #each_line on
  #   the file, pointing at the first line describing edges
  def make_adjacency_list(file_iterator)
    @adjacency_list = Array.new(num_edges) { [] }
    line = file_iterator.next.chomp
    loop do
      add_to_adjacency_list(line)
      line = file_iterator.next.chomp

      # Note that this will skip the line containing the number of operations.
      # That information can be determined by taking the length of the array
      # of operations. The alternative is to rewind the iterator or make it
      # peekable and break the loop by peeking after each iteration, neither
      # of which is as efficient.
      break unless line =~ /^\d+ \d+$/
    end
  end

  # Helper method for #make_adjacency_list. Adds the second node to the first
  # one's entry and vice versa.
  #
  # @param line [String] a string containing two connected edges.
  def add_to_adjacency_list(line)
    connected_nodes = line.split(" ").map { |e| e.to_i.pred } # We convert to zero-indexed
    adjacency_list[connected_nodes.first] << connected_nodes.last
    adjacency_list[connected_nodes.last] << connected_nodes.first
  end

  # Sets the instance variable @operations by taking from the enumerator until
  # it's tapped out.
  #
  # @param file_iterator [Enumerator] the enumerator from calling #each_line on
  #   the file, pointing at the first line describing operations
  def make_operations(file_iterator)
    @operations = []
    file_iterator.each do |line|
      line = line.chomp.split(" ")
      @operations << if line.first == "add"
                       Tree::Add.new(line[1].to_i.pred, line[2].to_i)
                     else
                       Tree::Max.new(line[1].to_i.pred, line[2].to_i.pred)
      end
    end
  end

end
