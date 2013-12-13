class Hash
  def get_leaf(*args, &block)
    DeepTree.get_leaf( self, *args, &block )
  end
end