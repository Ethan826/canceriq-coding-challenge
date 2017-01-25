require_relative "tree_controller"

module Tree

  class TreeNavigator

    attr_reader :tree

    def initialize(tree)
      @tree = tree
    end

    def nodes_on_path(start_node, end_node)
      # Swap "start" node if it's at a higher depth than "end" node (so we traverse up)
      start_node, end_node = end_node, start_node if tree[end_node].depth > tree[start_node].depth
      position = start_node
      route = [position, end_node].to_set
      (tree[start_node].depth - tree[end_node].depth).times do
        position = tree[position].parent
        route << position
      end
      while position != end_node
        position = tree[position].parent
        end_node = tree[end_node].parent
        route += [position, end_node]
      end
      route
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

end
