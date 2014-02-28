# -*- encoding: utf-8 -*-



Gem::Specification.new do |s|
  s.name = "jira-rest"
  s.version = File.read('VERSION')
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["tiago.l.nobre@gmail.com"]
  s.date = "2013-11-08"
  s.description = ""
  s.email = "tiago.l.nobre@gmail.com"
  s.extra_rdoc_files = %w( LICENSE README.md )
  s.files = %w( LICENSE lib/JiraRest.rb lib/Struct.rb )
  s.homepage = "http://github.com/macwadu/jira-rest"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.25"
  s.summary = "JIRA REST API"


end

