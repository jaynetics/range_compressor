lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'range_compressor/version'

Gem::Specification.new do |s|
  s.name          = 'range_compressor'
  s.version       = RangeCompressor::VERSION
  s.authors       = ['Janosch Müller']
  s.email         = ['janosch84@gmail.com']

  s.summary       = 'Compresses Arrays of Objects to Arrays of Ranges.'
  s.homepage      = 'https://github.com/jaynetics/range_compressor'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 1.9.3'

  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.8'
end
