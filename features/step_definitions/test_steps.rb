include Test::Unit::Assertions
require 'jirarest'

Given /^I create instantiation of Jira with authentication$/ do
  @jira = JiraRest::Client.new('https://jira.atlassian.com', 'tiago.l.nobre', '123qweasd')
end

Given /^I create instantiation of Jira$/ do
  @jira = JiraRest::Search.new('https://jira.atlassian.com')
end

Then(/^I can get the versions of the project with the key "([^"]*)"$/) do |key|
  result, msg = @jira.get_versions key
  assert_equal(true, result, msg)
  assert(!@jira.actual_version.nil?, 'Can\'t get actual version')
  puts "Actual version: #{@jira.actual_version}"
  assert(!@jira.actual_version.nil?, 'Can\'t get next version')
  puts "Next version: #{@jira.next_version}"
end

Then(/^I can get all versions for the "([^"]*)" project$/) do |project|
  resp, msg = @jira.get_versions project
  assert(resp, msg)
  assert(!@jira.all_versions.empty?, 'Can\'t get next version')
  puts "All version: #{@jira.all_versions}"
end

Then(/^I query by hash (.*)$/) do |query|
  jqlquery_result = @jira.search.query_by_hash(eval(query))
  assert_equal(true, jqlquery_result.success, jqlquery_result.error_msg)
  puts jqlquery_result.body
  assert(!jqlquery_result.body.empty?, 'Tickets are empty')
end

Then(/^I jql query jira (.*)$/) do |string|
  jqlquery_result = @jira.search.jqlquery(string, nil, 200)
  assert_equal(true, jqlquery_result.success, jqlquery_result.error_msg)
  assert(!jqlquery_result.body.empty?, 'Tickets are empty')
  jqlquery_result.body.each { |ticket| p ticket }
end

Then(/^I check that the project "([^"]*)" existence is "([^"]*)"$/) do |project, exist|

  result, msg = @jira.get_versions project
  p "Project: #{project} - #{result}"
  p "Message: #{msg}"
  assert_equal(eval(exist), result, msg)
end

Given /^I search for issue id "(.*)"$/ do |issue|
  result = @jira.search.issue issue
  p result
  assert_equal(true, result.success, result.error_msg)
  puts result.body
end

Given(/^I search for filter id "([^"]*)"$/) do |id|
  result = @jira.search.filter id
  assert_equal(true, result.success, result.error_msg)
  result.body.each { |ticket| p ticket }
end