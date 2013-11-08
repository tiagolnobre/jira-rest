# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "jira-rest"
  gem.homepage = "http://github.com/tiago.l.nobre@gmail.com/jira-rest"
  gem.license = "MIT"
  gem.summary = %Q{JIRA REST API}
  gem.description = %Q{}
  gem.email = "tiago.l.nobre@gmail.com"
  gem.authors = ["tiago.l.nobre@gmail.com"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty"
end

task :default => :features

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "jira-rest #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
