lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'minarai/version'

Gem::Specification.new do |spec|
  spec.name          = 'minarai'
  spec.version       = Minarai::VERSION
  spec.authors       = ['ganmacs']
  spec.email         = ['ganmacs@gmail.com']
  spec.summary       = 'Minarai Configuration Tool'
  spec.homepage      = 'https://github.com/ganmacs/minarai'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 4.2.1'
  spec.add_dependency 'activemodel', '~> 4.2.0'
  spec.add_dependency 'specinfra', '~> 2.28.0'
  spec.add_dependency 'hashie', '~> 3.4.0'
  spec.add_dependency 'slop', '~> 4.0.0'
  spec.add_dependency 'ansi', '~> 1.5.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2.0'
  spec.add_development_dependency 'rubocop', '~> 0.29.0'
end
