require_relative 'benchmark_helper'

good_path = %w(three_level level_two level_one)

puts "Good Path"
Benchmark.bm do |x|
  x.report('DeepTree::get_leaf') do
    $iterations.times { DeepTree.get_leaf($hash, *good_path) }
  end
  x.report('Hash#get_leaf     ') do
    $iterations.times { $hash.get_leaf($hash, *good_path) }
  end
  x.report('DeepTree#get_leaf ') do
    $iterations.times { tree = DeepTree.new($hash); tree.get_leaf($hash, *good_path) }
  end
  x.report('Hash[] w/ rescue  ') do
    $iterations.times { $hash['three_level']['level_two']['level_one'] rescue nil }
  end
  x.report('Hashie::Mash      ') do
    $iterations.times { Hashie::Mash.new($hash).three_level.level_two.level_one }
  end
end