# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heckle/version'

Gem::Specification.new do |spec|
  spec.name          = "heckle"
  spec.version       = Heckle::VERSION
  spec.authors       = ["Ryan Davis", "Pete Higgins"]
  spec.email         = ["ryand-ruby@zenspider.com", "pete@peterhiggins.org"]

  spec.summary       = "Heckle is unit test sadism(tm) at its core"
  spec.description   = "Heckle is unit test sadism(tm) at its core. Heckle is a mutation tester. It modifies your code and runs your tests to make sure they fail. The idea is that if code can be changed and your tests don't notice, either that code isn't being covered or it doesn't do anything.\n\nIt's like hiring a white-hat hacker to try to break into your server and making sure you detect it. You learn the most by trying to break things and watching the outcome in an act of unit test sadism."

  spec.homepage      = "http://ruby.sadi.st/Heckle.html"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = "bin"
  spec.executables   = ["heckle"]
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruby_parser", "~> 3.8.3"
  spec.add_runtime_dependency "ruby2ruby", "~> 2.3.1"
  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "minitest", "~> 5.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rdoc", "~> 5.0"
end
