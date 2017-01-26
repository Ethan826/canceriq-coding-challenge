module Tree

  class TreeController

    attr_reader :values, :output

    # @param tree_navigator [Tree::TreeNavigator]
    def initialize(tree_navigator)
      @tree_navigator = tree_navigator
      @values = Array.new(tree_navigator.num_nodes) { 0 }
    end

    # Run a series of operations through this tree's structure and return the
    # results of all calls to #max.
    #
    # @param operations_list [Array<Tree::Add | Tree::Max>] the operations to
    #   perform with this tree
    # @return [Array<Int>] the values resulting from each call to #max as the
    #   tree is serially modified by the calls to #add
    def run(operations_list)
      output = []
      operations_list.each do |operation|
        if operation.is_a? Tree::Add
          add(operation.node, operation.value)
        else
          output << max(operation.start_node, operation.end_node)
        end
      end
      output
    end

    # Add the given number to node and its descendents.
    #
    # @param node [Int] the node whose value and that of its descendents will
    #   be changed by adding value
    # @param value [Int] the value to add to node and its descendents
    def add(node, value)
      tree_navigator.descendents(node).each do |descendent|
        values[descendent] += value
      end
    end

    # Find the maximum value along the path from start_node to end_node
    #
    # @param start_node [Int] one of two endpoints of the path to traverse and
    #   along which to take the max
    # @param end_node [Int] one of the two endpoints of the path to traverse and
    #   along which to take the max
    def max(start_node, end_node)
      # Reduce to avoid two traversals with #map then #max
      tree_navigator.nodes_on_path(start_node, end_node).reduce(-1.0 / 0) do |max, node|
        values[node] > max ? values[node] : max
      end
    end

    private

    attr_reader :tree_navigator

  end

end
