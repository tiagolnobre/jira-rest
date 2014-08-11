Feature: JiraRest::Search

  Scenario: Jql by Hash
    Given I create instantiation of Jira with authentication
    Then I query by hash {:project => 'DEMO', :status => '"in progress", Open'}

  Scenario: Jql by string
    Given I create instantiation of Jira with authentication
    Then I jql query jira project in (DEMO) AND status in ("in progress", Open)

  Scenario: Issue id
    Given I create instantiation of Jira with authentication
    Given I search for issue id "JRA-9"

  Scenario: Filter id
    Given I create instantiation of Jira with authentication
    Given I search for filter id "12843"
