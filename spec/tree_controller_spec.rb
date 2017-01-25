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

    def nodes_on_path(start_node, end_node)
      { [3, 3] => [3],
        [2, 4] => [2, 1, 0, 4],
        [2, 0] => [2, 1, 0] }.fetch([start_node, end_node])
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

  describe "#run" do
    it "performs an add" do
      subject.run([Tree::Add.new(2, 10)])
      expect(subject.values).to eq([0, 0, 10, 0, 0])
    end

    it "performs multiple adds" do
      subject.run([Tree::Add.new(3, 20), Tree::Add.new(0, 15)])
      expect(subject.values).to eq([15, 15, 15, 35, 15])
    end

    it "performs a max" do
      expect(subject.run([Tree::Max.new(2, 0)])).to eq([0])
    end

    it "performs multiple operations" do
      result = subject.run([Tree::Add.new(3, 20),
                            Tree::Add.new(0, 15),
                            Tree::Max.new(2, 0),
                            Tree::Add.new(4, 50),
                            Tree::Max.new(2, 4)])
      expect(result).to eq([15, 65])
    end
  end
end
