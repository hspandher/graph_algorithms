class Node
  def initialize object, key = object
    @object, @key = object, key
  end

  attr_reader :object, :key

  def == other
    @key == if other.respond_to?(:key) then other.key else other end
  end

  def to_s
    @key.to_s
  end

  def hash
    self.key.hash
  end

  alias :equal? :==
  alias :eql? :==
end

