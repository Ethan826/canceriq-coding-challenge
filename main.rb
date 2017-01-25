require "./src/file_parser"
require "./src/tree_helpers"
require "./src/tree_controller"
require "./src/tree_navigator"

input_path = ARGV[0]
output_path = ARGV[1]

if input_path && File.exist?(input_path)
  fp = FileParser.new(input_path)
  tn = Tree::TreeNavigator.new(Tree.tree_from(fp.adjacency_list))
  IO.write("./output.txt", Tree::TreeController.new(tn).run(fp.operations).join("\n"))
else
  puts "You must specify a file path as a command-line argument"
end
