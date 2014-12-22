# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bpp_client/version'

Gem::Specification.new do |spec|
  spec.name          = "bpp_client"
  spec.version       = BppClient::VERSION
  spec.authors       = ["Tagview"]
  spec.email         = ["contato@tagview.com.br"]
  spec.summary       = "Client for Brasil pre-pagos' API"
  spec.description   = "Ruby client for handling Brasil pre-pagos' API"
  spec.homepage      = "https://github.com/tagview/bpp_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "activeresource", '~> 4.0', '>= 4.0.0'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-byebug"
end
