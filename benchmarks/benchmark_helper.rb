require 'rubygems'
require 'bundler'
require 'require_relative' if RUBY_VERSION =~ /1\.8/
require 'benchmark'

require_relative '../lib/deep_tree'
require_relative '../lib/deep_tree/hash'

Bundler.require :benchmarks

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