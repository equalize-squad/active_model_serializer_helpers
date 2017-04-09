# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model_serializer_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_model_serializer_helpers'
  spec.version       = ActiveModelSerializerHelpers::VERSION
  spec.authors       = ['Rogério Rodrigues de Alcântara']
  spec.email         = ['rogerio.alcantara@gmail.com']

  spec.summary       = 'Active Model Serializer Helpers'
  spec.description   = 'Active Model Serializer RSpec Helpers and Matchers'
  spec.homepage      = 'https://github.com/roalcantara/active_model_serializer_helpers'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.2.3'
  spec.add_development_dependency 'github-rake-release', '~> 0.1.1.pre.alpha'

  spec.add_dependency 'rspec', '~> 3.0'
end
