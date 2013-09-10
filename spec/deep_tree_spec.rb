require_relative "spec_helper"

describe DeepTree do
  
  before do
    @result_data = {
      'one_level'   => 'SUCCESS',
      'three_level' => {
        'level_two' => {
          'level_one' => 'HOORAY'
        }
      }
    }
  end
  
  describe :class do
    
    it "raises an exception for invalid inputs" do
      proc { DeepTree.new(Array.new) }.must_raise(DeepTree::InvalidTreeError)
    end
    
    it "gets a leaf node" do
      DeepTree.get_leaf(@result_data, 'three_level', 'level_two', 'level_one').must_equal 'HOORAY'
    end
    
  end
  
  describe :instance do
    
    before(:each) do
      @deep_tree = DeepTree.new(@result_data)
    end
  
    it "gets a single level's node" do
      @deep_tree.get_leaf('one_level').must_equal 'SUCCESS'
    end
  
    it "gets a deeply nested node" do
      @deep_tree.get_leaf('three_level', 'level_two', 'level_one').must_equal 'HOORAY'
    end
  
    it "responds with nil for a shallow missing node" do
      @deep_tree.get_leaf('missing').must_be_nil
    end
  
    it "responds with nil for a deep missing node" do
      @deep_tree.get_leaf('three_level', 'level_two', 'missing').must_be_nil
    end
  
    it "responds with nil when it encounters a non-hash in the path" do
      @deep_tree.get_leaf('three_level', 'level_two', 'level_one', 'level_zero').must_be_nil
    end
  
    it "evaluates a block instead of returning nil if a block is given" do
      @deep_tree.get_leaf('nope') { 'potato' }.must_equal 'potato'
    end
    
  end
  
end