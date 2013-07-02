# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'factory_girl-seeds/version'

Gem::Specification.new do |gem|
  gem.name          = "factory_girl-seeds"
  gem.version       = FactoryGirl::Seeds::VERSION
  gem.authors       = ["Alexander Balashov"]
  gem.email         = ["technoforest@gmail.com"]
  gem.description   = %q{Preseed reusable data for factory girl}
  gem.summary       = %q{Make your test suite run time upto 2x faster and even more!}
  gem.homepage      = "https://github.com/evrone/factory_girl-seeds"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
