Feature: JiraRest::Search

  @hash
  Scenario: Jql by Hash
    Given I create instantiation of Jira with authentication
    Then I query by hash {:project => 'DEMO', :status => '"in progress", Open'}

  @string
  Scenario: Jql by string
    Given I create instantiation of Jira with authentication
    Then I jql query jira project in (DEMO) AND status in ("in progress", Open)

  @id
  Scenario: Issue id
    Given I create instantiation of Jira with authentication
    Given I search for issue id "JRA-9"
  @filter
  Scenario: Filter id
    Given I create instantiation of Jira with authentication
    Given I search for filter id "12843"
