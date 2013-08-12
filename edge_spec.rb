require './edge.rb'

describe Edge do
  before :each do
    @test_edge1 = Edge.new Node.new('A'), Node.new('B')
    @test_edge2 = Edge.new 'A', 'B'
    @test_edge3 = Edge.new Node.new('A'), Node.new('B'), 9
  end

  it 'should accept node objects as well as other objects as arguments' do
    @test_edge1.source.should == Node.new('A') and @test_edge1.destination.should == Node.new('B')
    @test_edge2.source.should == 'A' and @test_edge2.destination.should == 'B'
  end

  it 'should treat the edge weight as zero if none provided' do
    @test_edge1.weight.should == 0 and @test_edge2.weight.should == 0
    @test_edge3.weight.should == 9
  end

  it 'should treat two edges are equal if their source, destination and weight is equal' do
    @test_edge1.should == @test_edge2
    @test_edge1.should_not == @test_edge3
  end
end