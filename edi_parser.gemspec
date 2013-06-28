# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'edi_parser/version'

Gem::Specification.new do |spec|
  spec.name          = "edi_parser"
  spec.version       = EdiParser::VERSION
  spec.authors       = ["Matheus Tardivo"]
  spec.email         = ["matheustardivo@gmail.com"]
  spec.summary       = %q{Library simple and easy to use to parse EDI ocurrence files in the COTIN/SETCESP standards}
  spec.homepage      = "https://github.com/matheustardivo/edi_parser"
  spec.description   = spec.summary
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"     , "~> 1.3"
  spec.add_development_dependency "rspec-rails" , "~> 2.13"
  spec.add_development_dependency "rails"       , "~> 3.2"
  spec.add_development_dependency "rake"        , "~> 10.1"
  spec.add_development_dependency "sqlite3"     , "~> 1.3"
end
