require "set"

module Tree

  Node = Struct.new(:parent, :children, :depth)

  class TreeController

    attr_reader :values

    def initialize(tree_navigator)
      @tree_navigator = tree_navigator
      @values = Array.new(tree_navigator.num_nodes) { 0 }
    end

    def add(node, value)
      tree_navigator.descendents(node).each do |descendent|
        values[descendent] += value
      end
    end

    def max(start_node, end_node)
      # Reduce to avoid two traversals with #map then #max
      tree_navigator.route(start_node, end_node).reduce(-1.0/0) do |max, node|
        values[node] > max ? values[node] : max
      end
    end

    def self.tree_from(adjacency_list)
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

    private

    attr_reader :tree_navigator

  end

end
