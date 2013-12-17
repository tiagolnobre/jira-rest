require 'JiraRest'
Given /^I search for "(.*)"$/ do |issue|

  resp = JiraRest.new('https://jira.atlassian.com', 'tiago.l.nobre@gmail.com', 'superb@ck?')
  resp.get_issue issue
end


Given(/^I get the "(.*?)" project versions$/) do |project|

  resp = JiraRest.new('https://jira.atlassian.com', 'tiago.l.nobre@gmail.com', 'superb@ck?')
  resp.get_versions project
end