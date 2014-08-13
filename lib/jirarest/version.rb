module JiraRest
  VERSION = "0.1." + (defined?(ENV['TRAVIS_BUILD_NUMBER']) ? '0' : ENV['TRAVIS_BUILD_NUMBER'])
end
