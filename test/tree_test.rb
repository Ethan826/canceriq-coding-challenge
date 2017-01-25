require "minitest/autorun"
require_relative "../src/tree"

class TestFileParser < Minitest::Test

  attr_reader :easy_input, :harder_input

  def setup
    @easy_input = [[1], [0]]
    @harder_input = [[1, 4], [0, 2, 3], [1], [1], [0]]
  end

  def test_tree_easy
    t = Tree.new(easy_input)
    expected = [
      Tree::Node.new(nil, [1], 0),
      Tree::Node.new(0, [], 1),
    ]
    assert_equal(expected, t.tree)
  end

  def test_tree_harder
    t = Tree.new(harder_input)
    expected = [
      Tree::Node.new(nil, [1, 4], 0), # 0
      Tree::Node.new(0, [2, 3], 1),   # 1
      Tree::Node.new(1, [], 2),       # 2
      Tree::Node.new(1, [], 2),       # 3
      Tree::Node.new(0, [], 1),       # 4
    ]
    assert_equal(expected, t.tree)
  end

  def test_add_to_leaf
    t = Tree.new(harder_input)
    t.add(4, 20)
    expected = [0, 0, 0, 0, 20]
    assert_equal(expected, t.values)
  end

  def test_add_to_root
    t = Tree.new(harder_input)
    t.add(0, 20)
    expected = [20, 20, 20, 20, 20]
    assert_equal(expected, t.values)
  end

  def test_multiple_adds
    t = Tree.new(harder_input)
    t.add(0, 20)
    t.add(3, -10)
    t.add(1, 100)
    expected = [20, 120, 120, 110, 20]
    assert_equal(expected, t.values)
  end

end
