require "set"

module Tree

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
      tree_navigator.route(start_node, end_node).reduce(-1.0 / 0) do |max, node|
        values[node] > max ? values[node] : max
      end
    end

    private

    attr_reader :tree_navigator

  end

end
