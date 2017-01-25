require "spec_helper"
require "pry"

RSpec.describe FileParser do
  # binding.pry
  # Dir.foreach("./spec/") do |f|
  #   next unless f =~ /input.{3}txt/
  #   fp = FileParser.new("./spec/" + f)
  #   tn = Tree::TreeNavigator.new(Tree.tree_from(fp.adjacency_list))
  #   puts Tree::TreeController.new(tn).run(fp.operations).join("\n")
  # end
end
