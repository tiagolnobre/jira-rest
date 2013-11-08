require 'JiraRest'
Given /^I search for "(.*)"$/ do |issue|

  resp = JiraRest.new('https://jira.atlassian.com', 'tiago.l.nobre@gmail.com', 'superb@ck?')
  resp.get_issue issue
end