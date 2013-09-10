require_relative "spec_helper"

describe Hash do
  
  describe :instance do
    
    before(:each) do
      @result_data = {
        'one_level'   => 'SUCCESS',
        'three_level' => {
          'level_two' => {
            'level_one' => 'HOORAY'
          }
        }
      }
    end
  
    it "responds to get_leaf" do
      @result_data.respond_to?(:get_leaf).must_equal true
    end
  
    it "gets a single level's node" do
      @result_data.get_leaf('one_level').must_equal 'SUCCESS'
    end
  
    it "gets a deeply nested node" do
      @result_data.get_leaf('three_level', 'level_two', 'level_one').must_equal 'HOORAY'
    end
  
    it "responds with nil for a shallow missing node" do
      @result_data.get_leaf('missing').must_be_nil
    end
  
    it "responds with nil for a deep missing node" do
      @result_data.get_leaf('three_level', 'level_two', 'missing').must_be_nil
    end
  
    it "responds with nil when it encounters a non-hash in the path" do
      @result_data.get_leaf('three_level', 'level_two', 'level_one', 'level_zero').must_be_nil
    end
  
    it "evaluates a block instead of returning nil if a block is given" do
      @result_data.get_leaf('nope') { 'potato' }.must_equal 'potato'
    end
    
  end
  
end