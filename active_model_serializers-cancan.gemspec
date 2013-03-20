# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_serializers/cancan/version'

Gem::Specification.new do |gem|
  gem.name          = "active_model_serializers-cancan"
  gem.version       = ActiveModel::Serializers::Cancan::VERSION
  gem.authors       = ["Gordon L. Hempton"]
  gem.email         = ["ghempton@gmail.com"]
  gem.summary       = %q{CanCan integration with Active Model Serializers}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "active_model_serializers", "~> 0.7.0"
  gem.add_dependency "cancan", "~> 1.6.9"
end
