# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'applocate/version'

Gem::Specification.new do |spec|
  spec.name          = "applocate"
  spec.version       = Applocate::VERSION
  spec.authors       = ["Mark Madsen"]
  spec.email         = ["mm@idyll.io"]
  spec.summary       = 'Server API client for Applocate'
  spec.description   = 'Connect to applocate and provision devices and push profiles.'
  spec.homepage      = 'https://www.applocate.com'
  spec.license       = "MIT"

  spec.add_runtime_dependency 'httparty'

  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'bundler', "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
end
