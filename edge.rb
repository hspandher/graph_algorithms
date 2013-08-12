require './node.rb'

class Edge
  def initialize source, destination, weight = 0
    source = Node.new source unless source.instance_of? Node
    destination = Node.new destination unless destination.instance_of? Node
    
    @source, @destination, @weight = source, destination, weight.to_i
  end

  attr_reader :source, :destination, :weight

  def to_s
    @source.to_s + ' => ' + @destination.to_s + " (#{@weight})"
  end

  def == other
    self.source == other.source and self.destination == other.destination and self.weight.to_i == other.weight.to_i
  end

  alias :equal? :==
  alias :eql? :==
end
