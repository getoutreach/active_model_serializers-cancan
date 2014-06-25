# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_serializers/cancan/version'

Gem::Specification.new do |gem|
  gem.name          = "active_model_serializers_cancancan"
  gem.version       = ActiveModel::Serializers::Cancan::VERSION
  gem.authors       = ["GlebTv", "Gordon L. Hempton"]
  gem.email         = ["glebtv@gmail.com"]
  gem.summary       = %q{CanCanCan integration with Active Model Serializers}
  gem.homepage      = "https://github.com/glebtv/active_model_serializers_cancancan"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'active_model_serializers'
  gem.add_dependency 'cancancan'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'mongoid', '~> 4.0.0.beta1'
end
