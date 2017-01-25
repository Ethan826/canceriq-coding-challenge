require "spec_helper"

RSpec.describe Tree do
  context "easy input" do
    let(:input) { [[1], [0]] }

    it "parses easy input" do
      expected = [Tree::Node.new(nil, [1], 0), Tree::Node.new(0, [], 1)]
      expect(Tree.tree_from(input)).to eq(expected)
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
      expect(Tree.tree_from(input)).to eq(expected)
    end
  end
end
