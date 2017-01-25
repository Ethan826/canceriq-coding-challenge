require "pry"

class Tree

  attr_reader :tree, :values

  Node = Struct.new(:parent, :children, :depth)

  def initialize(adjacency_list)
    @tree = tree_from(adjacency_list)
    @values = Array.new(tree.length) { 0 }
  end

  def add(node, value)
    descendents(node).each do |descendent|
      values[descendent] += value
    end
  end

  private

  def tree_from(adjacency_list)
    tree = Array.new(adjacency_list.length)

    # Prep for the loop
    depth = 0
    current_generation = [0]
    next_generation = []

    loop do
      current_generation.each do |current|
        next_generation += adjacency_list[current]

        # Get the parent dropped off during previous iteration
        tree[current] = Node.new(tree[current], adjacency_list[current], depth)

        next_generation.each do |id|
          adjacency_list[id].delete(current)

          # Leave the parent in the children's spots for next iteration
          tree[id] = current if tree[id].nil?
        end
      end

      break if current_generation.empty?

      current_generation = next_generation
      next_generation = []
      depth += 1
    end
    tree
  end

  def descendents(top_node) # We could memoize, but it would require a lot of space
    processed = []
    unprocessed = [top_node]
    until unprocessed.empty?
      unprocessed.each do |node|
        unprocessed.delete(node)
        processed << node
        unprocessed += tree[node].children
      end
    end
    processed
  end

end
