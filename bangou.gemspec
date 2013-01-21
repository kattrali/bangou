# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Delisa Mason"]
  gem.email         = ["iskanamagus@gmail.com"]
  gem.description   = %q{Integer <=> Japanese number converter}
  gem.summary       = %q{A library for converting between positive integers and Sino-Japanese numbers or text.}
  gem.homepage      = "http://kattrali.github.com/bangou"
  gem.version       = '1.1'
  gem.name          = "bangou"
  gem.require_paths = ["lib"]
  gem.extra_rdoc_files = ['readme.md']
  gem.add_development_dependency('bacon')
  gem.files = %W{
    Gemfile
    Rakefile
    LICENSE
    readme.md
    lib/bangou.rb
    lib/extensions/integer.rb
    spec/bangou_spec.rb
  }
  gem.test_files = gem.files.grep(%r{^(spec)/})
end
