require "spec_helper"

RSpec.describe FileParser do
  let(:path) { File.join(File.expand_path(File.dirname(__FILE__)), "input00.txt") }
  subject { described_class.new(path) }

  describe "#num_edges" do
    specify { expect(subject.num_edges).to eq(5) }
  end

  describe "#adjacency_list" do
    expected = [[1, 4], [0, 2, 3], [1], [1], [0]]
    specify { expect(subject.adjacency_list).to eq(expected) }
  end

  describe "#num_operations" do
    specify { expect(subject.num_operations).to eq(6) }
  end

  describe "#operations" do
    expected = [
      Tree::Add.new(3, 30),
      Tree::Add.new(4, 20),
      Tree::Max.new(3, 4),
      Tree::Add.new(1, -20),
      Tree::Max.new(3, 4),
      Tree::Max.new(2, 3),
    ]

    specify { expect(subject.operations).to eq(expected) }
  end
end
