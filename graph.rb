require './edge.rb'

class Graph
  def initialize node_list = [], edge_list = []
    @nodes, @edges = [], {}
    node_list.each {|node| self.add_node node}
    edge_list.each {|edge| self.add_edge edge}
  end

  attr_reader :nodes, :edges

  def add_node node
    node = Node.new node unless node.kind_of? Node
    @nodes.push node and @edges[node] = [] unless @nodes.include? node
  end

  def add_edge edge
    # if edge is not an Edge object, instead an array containg source, destination and weight
    edge = create_edge_object(edge) if edge.kind_of? Array

    if valid_edge? edge
      source = edge.source
      @edges[source].push edge unless @edges[source].include? edge
    end
  end

  def leaf_node? node
    @edges[node].empty?
  end

  def each_child node
    raise "Can't find children of #{node} since it is not added in graph" unless @nodes.include? node
    children = []
    @edges[node].each do |edge|
      yield edge.destination
    end
  end

  def edge_cost parent_node, child_node
    parent_node = Node.new parent_node unless parent_node.kind_of? Node
    # because parent_node needs to be used as a key
    @edges[parent_node].each do |edge|
      return edge.weight if edge.source == parent_node and edge.destination == child_node
    end
    raise 'Edge cost cannot be determined since two nodes are not connected'
  end

  def add_edge_from_string edge_string
    # edge_string should be in the form of 'source destination weight'
    source, destination, weight = edge_string.split

    nodes = [Node.new(source.to_s), Node.new(destination.to_s)]
    nodes.each {|node| self.add_node node}
    add_edge Edge.new(nodes[0], nodes[1], weight)
  end

  def to_s
    string_form = ''
    @nodes.each do |node|
      @edges[node].each do |edge|
        string_form.concat edge.to_s
        string_form.concat "\n"
      end
    end
    string_form
  end

  private
  def valid_edge? edge
    unless @nodes.include? edge.source and @nodes.include? edge.destination
      exception_message = "Can't add edge: both source & destination of edge should be in graph"
      raise exception_message
    end
    true
  end

  def create_edge_object edge_array
    Edge.new edge_array[0], edge_array[1], edge_array[2]
  end
end