# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deep_tree/version'

Gem::Specification.new do |gem|
  gem.name          = "deep_tree"
  gem.version       = DeepTree::VERSION
  gem.authors       = ["Patrick Tulskie"]
  gem.email         = ["patricktulskie@gmail.com"]
  gem.description   = %q{DeepTree simplifies fetching deeply nested nodes in Ruby hashes.}
  gem.summary       = %q{Aids with finding deeply nested nodes in Ruby hashes.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency('minitest')
end
