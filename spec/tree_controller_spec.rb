require "spec_helper"

RSpec.describe Tree::TreeController do
  subject { described_class.new(tree_navigator) }
  let(:tree_navigator) { TreeNavigatorMock.new }

  class TreeNavigatorMock

    def num_nodes
      5
    end

    def descendents(node)
      [[0, 1, 2, 3, 4], [1, 2, 3], [2], [3], [4]].fetch(node)
    end

    def route(start_node, end_node)
      { [3, 3] => [3], [2, 4] => [2, 1, 0, 4] }.fetch([start_node, end_node])
    end

  end

  describe "#add" do
    it "adds to leaf" do
      subject.add(4, 20)
      expected = [0, 0, 0, 0, 20]
      expect(subject.values).to eq(expected)
    end

    it "adds to root" do
      subject.add(0, 20)
      expected = [20, 20, 20, 20, 20]
      expect(subject.values).to eq(expected)
    end

    it "add multiple times" do
      subject.add(0, 20)
      subject.add(3, -10)
      subject.add(1, 100)
      expected = [20, 120, 120, 110, 20]
      expect(subject.values).to eq(expected)
    end
  end

  describe "#max" do
    before do
      subject.instance_variable_set(:@values, [10, 20, 30, 40, 50])
    end

    it "finds the max for self" do
      expect(subject.max(3, 3)).to eq(40)
    end

    it "finds the max for a route" do
      expect(subject.max(2, 4)).to eq(50)
    end
  end
end
