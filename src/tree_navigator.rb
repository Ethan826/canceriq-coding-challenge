module Tree

  class TreeNavigator

    attr_reader :tree

    # @param [Array<Tree::Node>] an array of nodes, each index corresponding
    #   to the node number
    def initialize(tree)
      @tree = tree
    end

    # Returns the number of nodes in the tree.
    #
    # @return [Int] the number of nodes in the tree
    def num_nodes
      tree.length
    end

    # The nodes encountered on the path between the specified nodes. Sequence
    # is not guaranteed and there may be duplicates.
    #
    # @param start_node [Int] the starting node
    # @param end_node [Int] the ending node
    # @return [Array<Int>] the nodes encountered on the path from start_node to
    #   end_node in arbitrary order possibly with duplicates
    def nodes_on_path(start_node, end_node)
      # Swap "start" node if it's at a higher depth than "end" node (so we can
      # traverse up)
      start_node, end_node = end_node, start_node if tree[end_node].depth > tree[start_node].depth
      position = start_node
      route = [position, end_node] # Initialize with the endpoints

      # Traverse up from the deepest node until they are on the same level
      (tree[start_node].depth - tree[end_node].depth).times do
        position = tree[position].parent
        route << position
      end

      # Traverse both nodes up a level at a time until they are equal
      while position != end_node
        position = tree[position].parent
        end_node = tree[end_node].parent
        route += [position, end_node]
      end
      route
    end

    # Find all descendents of the specified node.
    #
    # @param top_node [Int] the node whose descendents we want
    # @return [Array<Int>] the descendents of the specified node
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
