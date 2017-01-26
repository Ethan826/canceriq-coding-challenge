require "spec_helper"

RSpec.describe Tree::TreeNavigator do
  subject { described_class.new(tree) }
  let(:tree) do
    [
      Tree::Node.new(nil, [1, 4], 0),
      Tree::Node.new(0, [2, 3], 1),
      Tree::Node.new(1, [], 2),
      Tree::Node.new(1, [], 2),
      Tree::Node.new(0, [], 1),
    ]
  end

  describe "#num_nodes" do
    specify { expect(subject.num_nodes).to eq(5) }
  end

  describe "#nodes_on_path" do
    it "can find path to itself" do
      expect(subject.nodes_on_path(3, 3).sort.uniq).to match([3].sort)
    end

    it "can find path from root to leaf" do
      expect(subject.nodes_on_path(3, 0).sort.uniq).to match([3, 1, 0].sort)
    end

    it "can find path from leaf to root" do
      expect(subject.nodes_on_path(0, 3).sort.uniq).to match([0, 1, 3].sort)
    end

    it "can find path to a distant leaf" do
      expect(subject.nodes_on_path(2, 4).sort.uniq).to match([2, 1, 0, 4].sort)
    end
  end
end
