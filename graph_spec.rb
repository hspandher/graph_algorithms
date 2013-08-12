require './graph.rb'

describe Graph do
  before :each do
    @nodes = ['A', 'B', 'C', 'D', 'E']
    @edges = [['A', 'B', 8], ['B', 'C', 6], ['C', 'D', 7], ['C', 'E', 9]]

    @test_graph = Graph.new @nodes, @edges
  end

  it 'should be creatable as an empty graph' do
    test_graph = Graph.new
    test_graph.nodes.should be_empty
    test_graph.edges.should be_empty
  end

  it 'should accept list of nodes and edges in constructor directly too' do
    @test_graph.nodes.should == @nodes
  end

  it 'should add node to the graph even if it is not node object and turn it into node object' do
    test_graph = Graph.new
    test_graph.add_node 'A'
    test_graph.nodes.should include 'A'
  end

  it 'should add edge for nodes in graph , otherwise raise exception' do
    test_graph = Graph.new
    expect {test_graph.add_edge Edge.new('A', 'B')}.to raise_error
    ['A', 'B'].each {|node| test_graph.add_node node}
    test_graph.add_edge Edge.new('A', 'B')
    test_graph.edges[Node.new 'A'].should include(Edge.new('A', 'B'))
  end

  it 'should return true for a leaf node i.e. node without children' do
    @test_graph.should be_leaf_node Node.new('E')
    @test_graph.should_not be_leaf_node Node.new('A')
  end

  it 'should yeild , all child nodes of the node, to the graph' do
    actual_result = []
    @test_graph.each_child(Node.new 'C') {|child| actual_result << child}
    expected_result = ['D', 'E']
    actual_result.should == expected_result
  end

  it 'should return the edge cost of an edge between two connected nodes' do
    # @test_graph.edge_cost(Node.new('C'), Node.new('E')).should == 9
    @test_graph.edge_cost(Node.new('A'), Node.new('B')).should == 8
  end

  it 'should accept an edge as a string, for convenience sake' do
    test_graph = Graph.new
    test_graph.add_edge_from_string "7 1"
    test_graph.add_edge_from_string "4 6 888"

    test_graph.edges[Node.new '7'].should include Edge.new('7', '1')
    test_graph.edges[Node.new '4'].should include Edge.new('4', '6', '888')
  end

  it 'should return the string represenation of the graph' do
    @test_graph.to_s.should be_instance_of String
  end
end




