lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domainblob/version'

Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.0.0'
  s.platform    = Gem::Platform::RUBY
  s.version     = Domainblob::VERSION
  s.name        = 'domainblob'
  s.date        = '2015-10-18'
  s.summary     = 'Bulk Domain Name Checker'
  s.description = 'Check available domain names, in bulk!'
  s.authors     = ['Joe Norton']
  s.email       = ['joe@norton.io']
  s.homepage    = ''
  s.license     = 'MIT'
  # If you need to check in files that aren't .rb files, add them here
  s.files        = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md',
                       '{spec}/*.rb']
  s.require_path = 'lib'
  s.rubyforge_project         = 'domainblob'

  # If you need an executable, add it here
  s.executables = ['db']
  s.required_rubygems_version = '>= 1.3.6'

  # If you have other dependencies, add them here
  s.add_runtime_dependency 'whois'

  s.add_development_dependency 'bundler', '~> 1.6'
  s.add_development_dependency 'rake', '~> 10.3'
  s.add_development_dependency 'rspec', '~> 2.14'
  s.add_development_dependency 'pry'
end