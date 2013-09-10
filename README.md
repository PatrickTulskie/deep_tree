# DeepTree

DeepTree is a simple class that loops through nodes in nested hashes to find a node that you're looking for.  It's built to alleviate this:

    tons_of_hashes['first_node']['second_node']['third_node'] rescue nil
    
Not only does this mask other issues in your code, but it is also super slow especially if you're digging through the same tree structure several times in a given app.

## Installation

Add this line to your application's Gemfile:

    gem 'deep_tree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install deep_tree
    
## Usage

There are three ways to use DeepTree depending on your needs.  The first way is to simply use an instance:

    tree = DeepTree.new(tons_of_hashes)
    tree.get_leaf('first_node', 'second_node', 'third_node')
    
Another way to use it is by extending the `Hash` class.

    require 'deep_tree/hash'
    tons_of_hashes.get_leaf('first_node', 'second_node', 'third_node')
    
Many people try not to reopen Ruby's base classes.  If you want this functionality on the `Hash` class then you can load it up.  If you don't then you don't have to.

Finally, you can just use the class method like this:

    DeepTree.get_leaf(tons_of_hashes, 'first_node', 'second_node')

Additionally, `DeepTree::get_leaf` supports evaluating a block if the result is `nil`.

    DeepTree.get_leaf(tons_of_hashes, 'first_node', 'second_node') do
      logger.info('That leaf couldn't be found.')
      nil
    end
    
Both the instance and hash extension all use `DeepTree::get_leaf` so they support passing a block as well.

## A Caveat

All nodes except for the final leaf must be hashes in order for this to work.  DeepTree will return nil for anything else.

## Benchmarks

These test were run on a MacBook Pro Retina 2.7ghz w/ 16 GB RAM.  Each test was run 200k times.

    Good Path
                           user     system      total        real
    DeepTree::get_leaf  0.550000   0.000000   0.550000 (  0.544478)
    Hash#get_leaf       1.060000   0.010000   1.070000 (  1.067833)
    DeepTree#get_leaf   1.310000   0.020000   1.330000 (  1.332804)
    Hash[] w/ rescue    0.150000   0.010000   0.160000 (  0.158904)

    Bad Path
                           user     system      total        real
    DeepTree::get_leaf  0.420000   0.000000   0.420000 (  0.423668)
    Hash#get_leaf       1.060000   0.020000   1.080000 (  1.079373)
    DeepTree#get_leaf   1.320000   0.010000   1.330000 (  1.336181)
    Hash[] w/ rescue    2.800000   0.220000   3.020000 (  3.019637)

So, in the case where the whole path is good, simply chaining together hash calls is the clear winner.  In the event that the path is broken somewhere along the line, DeepTree's solution is at least 2x faster for this extremely contrived example.  Benchmarks are in the benchmarks directory for your viewing pleasure.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
