require "minitest/autorun"
require_relative "../src/tree_navigator"


class TestTreeNavigator < Minitest::Test

  attr_reader :tree

  def setup
    @tree = [
      Tree::Node.new(nil, [1, 4], 0), # 0
      Tree::Node.new(0, [2, 3], 1),   # 1
      Tree::Node.new(1, [], 2),       # 2
      Tree::Node.new(1, [], 2),       # 3
      Tree::Node.new(0, [], 1),       # 4
    ]
  end

  def test_nodes_on_path_to_self
    t = Tree::TreeNavigator.new(@tree)
    expected = [3]
    assert_equal(expected, t.nodes_on_path(3, 3).sort)
  end

  def test_nodes_on_path_leaf_to_root
    t = Tree::TreeNavigator.new(tree)
    expected = [3, 1, 0].sort
    assert_equal(expected, t.nodes_on_path(3, 0).sort)
  end

  def test_nodes_on_path_root_to_leaf
    t = Tree::TreeNavigator.new(tree)
    expected = [0, 1, 3].sort
    assert_equal(expected, t.nodes_on_path(0, 3).sort)
  end

  def test_nodes_on_path_leaf_to_sibling
    t = Tree::TreeNavigator.new(tree)
    expected = [2, 1, 3].sort
    assert_equal(expected, t.nodes_on_path(2, 3).sort)
  end

  def test_nodes_on_path_to_distant_leaf
    t = Tree::TreeNavigator.new(tree)
    expected = [2, 1, 0, 4].sort
    assert_equal(expected, t.nodes_on_path(2, 4).sort)
  end

end
