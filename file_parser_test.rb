require "minitest/autorun"
require_relative "file_parser"
require "tempfile"
require "set"

class TestFileParser < Minitest::Test

  attr_reader :subject

  def setup
    path = File.expand_path(File.dirname(__FILE__)) + "/input00.txt"
    @subject = FileParser.new(path)
  end

  def test_num_edges
    assert_equal(5, subject.num_edges)
  end

  def test_adjacency_list
    expected = [[1, 4].to_set,
                [0, 2, 3].to_set,
                [1].to_set,
                [1].to_set,
                [0].to_set]
    assert_equal(expected, subject.adjacency_list)
  end

  def test_num_operations
    assert_equal(6, subject.num_operations)
  end

  def test_operations
    expected = [
      FileParser::Add.new(4, 30),
      FileParser::Add.new(5, 20),
      FileParser::Max.new(4, 5),
      FileParser::Add.new(2, -20),
      FileParser::Max.new(4, 5),
      FileParser::Max.new(3, 4),
    ]
    assert_equal(expected, subject.operations)
  end

end

__END__
5
1 2
2 3
2 4
5 1
6
add 4 30
add 5 20
max 4 5
add 2 -20
max 4 5
max 3 4
