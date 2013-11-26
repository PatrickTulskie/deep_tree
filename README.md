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

These test were run on a MacBook Pro Retina 2.7ghz w/ 16 GB RAM.  Each test was run 200k times.  Benchmark files are in the benchmarks directory.

    Good Path
                           user     system      total        real
    DeepTree::get_leaf  0.260000   0.110000   0.370000 (  0.375624)
    Hash#get_leaf       0.500000   0.130000   0.630000 (  0.622437)
    DeepTree#get_leaf   0.600000   0.030000   0.630000 (  0.630710)
    Hash[] w/ rescue    0.080000   0.010000   0.090000 (  0.094365)
    Hashie::Mash        4.390000   0.240000   4.630000 (  4.617386)

    Bad Path
                           user     system      total        real
    DeepTree::get_leaf  0.210000   0.120000   0.330000 (  0.328618)
    Hash#get_leaf       0.530000   0.150000   0.680000 (  0.679037)
    DeepTree#get_leaf   0.620000   0.030000   0.650000 (  0.646792)
    Hash[] w/ rescue    0.510000   0.050000   0.560000 (  0.567455)
    Hashie::Mash        6.260000   0.400000   6.660000 (  6.744009)
    
So, in the case where the whole path is good, simply chaining together hash calls is the clear winner (but if that was always the case, you wouldn't be here right now).  In the event that the path is broken somewhere along the line, DeepTree's solution is at least 2x faster for this extremely contrived example.  Benchmarks are in the benchmarks directory for your viewing pleasure.

I recently added Hashie::Mash to the mix here since everyone I showed this to told me that I should try Hashie::Mash.  I have had lots of performance and memory issues with Hashie::Mash in the past and as of the latest version (2.0.5) it doesn't seem to be any better.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
