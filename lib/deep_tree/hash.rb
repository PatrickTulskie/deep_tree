class Hash
  
  def get_leaf(*args)
    if block_given?
      DeepTree.get_leaf(self, *args) { yield }
    else
      DeepTree.get_leaf(self, *args)
    end
  end
  
end