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

  end

  context "easy input" do
    let(:input) { [[1], [0]] }

    it "parses easy input" do
      expected = [Tree::Node.new(nil, [1], 0), Tree::Node.new(0, [], 1)]
      expect(described_class.tree_from(input)).to eq(expected)
    end
  end

  context "harder input" do
    let(:input) { [[1, 4], [0, 2, 3], [1], [1], [0]] }

    it "parses harder input" do
      expected = [
        Tree::Node.new(nil, [1, 4], 0), # 0
        Tree::Node.new(0, [2, 3], 1),   # 1
        Tree::Node.new(1, [], 2),       # 2
        Tree::Node.new(1, [], 2),       # 3
        Tree::Node.new(0, [], 1),       # 4
      ]
      expect(described_class.tree_from(input)).to eq(expected)
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
      # let(:)
    end
  end
end
