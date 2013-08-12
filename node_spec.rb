require './node.rb'

describe Node do
  before :each do
    @test_node1 = Node.new 9
    @test_node2 = Node.new 'A'
    @test_node3 = Node.new 8, 'a'
  end

  it 'should accept all type of objects as a node' do
    @test_node1.object.should == 9
    @test_node2.object.should == 'A'
    @test_node3.object.should == 8
  end

  it 'should treat object as a key itself if no key is provided' do
    @test_node1.key.should == 9
    @test_node2.key.should == 'A'
  end

  it 'should return true if key of the node is equal to other object key or value' do
    @test_node1.should == Node.new(9)
    @test_node2.should == 'A'
    @test_node3.should_not == 8
  end

  it 'should return an integer when used as an hash key' do
    @test_node1.hash.class.should == Fixnum
    @test_node2.hash.class.should == Fixnum
    @test_node3.hash.class.should == Fixnum
  end
end