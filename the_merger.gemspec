# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'the_merger/version'

Gem::Specification.new do |gem|
  gem.name          = "the_merger"
  gem.version       = TheMerger::VERSION
  gem.authors       = ["Michael Pope"]
  gem.email         = ["map7777@gmail.com"]
  gem.description   = %q{Mail merge a table of fields into a standard letter}
  gem.summary       = %q{Mail Merge}
  gem.homepage      = "https://github.com/map7/the_merger"
  gem.license       = 'MIT'

  gem.add_dependency "mail"
  gem.add_dependency "redcarpet"
  
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
