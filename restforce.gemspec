# -*- encoding: utf-8 -*-
require File.expand_path('../lib/restforce/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Eric J. Holmes"]
  gem.email         = ["eric@ejholmes.net"]
  gem.description   = %q{A lightweight ruby client for the Salesforce REST api.}
  gem.summary       = %q{A lightweight ruby client for the Salesforce REST api.}
  gem.homepage      = "https://github.com/ejholmes/restforce"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "restforce"
  gem.require_paths = ["lib"]
  gem.version       = Restforce::VERSION

  gem.add_dependency 'faraday'
  gem.add_dependency 'faraday_middleware'
  gem.add_dependency 'json'
  gem.add_dependency 'hashie'

  gem.add_development_dependency 'rspec', '~> 2.14.0'
  gem.add_development_dependency 'webmock', '~> 1.13.0'
  gem.add_development_dependency 'simplecov', '~> 0.7.1'
  gem.add_development_dependency 'faye' unless RUBY_PLATFORM == 'java'
end
