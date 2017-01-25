require "spec_helper"

RSpec.describe FileParser do
  it "correctly parses the example files" do
    (0..5).each do |num|
      input_filename = "input%02d.txt" % num
      output_filename = "output%02d.txt" % num
      fp = FileParser.new(File.join(".", "spec", input_filename))
      tn = Tree::TreeNavigator.new(Tree.tree_from(fp.adjacency_list))
      result = Tree::TreeController.new(tn).run(fp.operations).join("\n") + "\n"
      expect(result).to eq(File.read(File.join(".", "spec", output_filename)))
    end
  end
end
