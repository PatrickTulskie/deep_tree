require 'rubygems'
require 'benchmark'
require_relative '../lib/deep_tree'
require_relative '../lib/deep_tree/hash'

$iterations = 200_000

$hash = {
  'one_level'   => 'SUCCESS',
  'three_level' => {
    'level_two' => {
      'level_one' => 'HOORAY'
    }
  }
}

GC.disable