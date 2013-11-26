require_relative 'benchmark_helper'

bad_path = %w(three_level nope nada)

puts "Bad Path"
Benchmark.bm do |x|
  x.report('DeepTree::get_leaf') do
    $iterations.times { DeepTree.get_leaf($hash, *bad_path) }
  end
  x.report('Hash#get_leaf     ') do
    $iterations.times { $hash.get_leaf($hash, *bad_path) }
  end
  x.report('DeepTree#get_leaf ') do
    $iterations.times { tree = DeepTree.new($hash); tree.get_leaf($hash, *bad_path) }
  end
  x.report('Hash[] w/ rescue  ') do
    $iterations.times { $hash['three_level']['nope']['nada'] rescue nil }
  end
  x.report('Hashie::Mash      ') do
    $iterations.times { Hashie::Mash.new($hash).three_level!.nope!.nada }
  end
end