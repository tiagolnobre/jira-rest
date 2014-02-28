require 'httparty'
require 'base64'
require 'timeout'

#require 'jiraRest/base'

require 'jirarest/client'
#require 'jiraRest/request'
require 'jirarest/search'

#to_h is present on ruby 2.0.0
require 'jirarest/struct' if RUBY_VERSION == '1.9.3'


  #module JiraRest
  #  extend self
  #end

#a = JiraRest::Client.new('https://jira.atlassian.com', 'tiago.l.nobre', '123qweasd')
#
#a.search.filter 1234
#
#p a.search.filter '12844'