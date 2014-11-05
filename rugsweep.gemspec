# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rugsweep/version'

Gem::Specification.new do |spec|
  spec.name          = "rugsweep"
  spec.version       = Rugsweep::VERSION
  spec.authors       = ["Jonathon M. Abbott"]
  spec.email         = ["jonathona@everydayhero.com.au"]
  spec.summary       = "sweep files under the rug"
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/JonathonMA/rugsweep"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "paint", "~> 0.8.7"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1.0"
  spec.add_development_dependency "rubocop", "~> 0.27.0"
end
