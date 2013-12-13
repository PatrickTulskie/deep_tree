class DeepTree
  
  Error            = Class.new(StandardError)
  InvalidTreeError = Class.new(Error)
  
  attr_accessor :tree
  
  def self.get_leaf(parent, *args, &block)
    args.each_with_index do |key, index|
      result = case
      when index == (args.length - 1)
        return parent[key].nil? && block ? yield : parent[key]
      when parent[key].is_a?(Hash)
        parent = parent[key]
      else
        return block ? yield : nil
      end
    end
  end
  
  def initialize(tree)
    if tree.kind_of?(Hash)
      self.tree = tree
    else
      raise InvalidTreeError, "Expected a kind of Hash but got an instance of #{tree.class}"
    end
  end
  
  def get_leaf(*args, &block)
    DeepTree.get_leaf( tree, *args, &block )
  end
  
  def method_missing(*args)
    self.tree(args)
  end
  
end