# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yapfac/version'

Gem::Specification.new do |spec|
  spec.name          = "yapfac"
  spec.version       = Yapfac::VERSION
  spec.authors       = ["William Eisert"]
  spec.email         = ["weisert@eisertdev.com"]

  spec.summary       = %q{Yet Another Parser for Apache Configuration}
  spec.description   = %q{Parsing and manipulation gem for Apache configuration files. Can also be used to control remote servers using a secure RESTful API. Think, Webmin.}
  spec.homepage      = "https://github.com/eiwi1101/yapfac"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
