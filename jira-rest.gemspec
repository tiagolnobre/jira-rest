# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jirarest/version'

Gem::Specification.new do |s|
  s.name                      = 'jira-rest'
  s.version                   = JiraRest::VERSION
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors                   = ['tiago.l.nobre@gmail.com']
  s.date                      = Time.now
  s.description               = 'jira-rest is a ruby lib to interact with JIRA'
  s.email                     = 'tiago.l.nobre@gmail.com'
  s.extra_rdoc_files          = %w( LICENSE.txt README.md )
  s.files                     = Dir.glob('{lib}/**/*')
  s.test_files                = s.files.grep(%r{^(test|spec|features)/})
  s.homepage                  = 'http://github.com/macwadu/jira-rest'
  s.licenses                  = ['MIT']
  s.require_paths             = ['lib']
  s.rubygems_version          = '1.8.25'
  s.summary                   = 'JIRA REST API'
  s.has_rdoc                  = 'yard'

  s.add_runtime_dependency('httparty','~> 0.11')
  s.add_development_dependency('cucumber', '~> 1.3')
  s.add_development_dependency('rake', '~> 10.1')
  s.add_development_dependency('yard', '~> 0.8')
  s.add_development_dependency('yard-cucumber', '~> 2.3')
  s.add_development_dependency('kramdown', '~> 2.3')
  s.add_development_dependency('coveralls', '~> 0')

end

