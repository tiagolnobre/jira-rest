require 'httparty'
require 'base64'
require 'timeout'

require 'jirarest/client'
require 'jirarest/search'

#to_h is present on ruby 2.0.0
require 'jirarest/struct' if RUBY_VERSION == '1.9.3'

