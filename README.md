jira-rest
=========

[![Gem Version](https://badge.fury.io/rb/jira-rest.png)](http://badge.fury.io/rb/jira-rest) [![Build Status](https://travis-ci.org/macwadu/jira-rest.png?branch=master)](https://travis-ci.org/macwadu/jira-rest) [![Code Climate](https://codeclimate.com/github/macwadu/jira-rest.png)](https://codeclimate.com/github/macwadu/jira-rest) [![Dependency Status](https://gemnasium.com/macwadu/jira-rest.png)](https://gemnasium.com/macwadu/jira-rest.png) [![Coverage Status](https://coveralls.io/repos/macwadu/jira-rest/badge.png)](https://coveralls.io/r/macwadu/jira-rest)

Installation
------------

Installation
------------

Add this line to your application's Gemfile:

```
gem 'jirarest'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install jira-rest
```

Usage
-----

```
require 'jira-rest'

@jira = JiraRest::Client.new(jira_host, username, password)
```

**Query by hash**

```
hash_query = {:project => 'DEMO', :status => '"in progress", Open'}
@jira.search.query_by_hash(hash_query)

optional:
@jira.search.query_by_hash(hash_query, return_fields, maxresults)
```

**Query by jql string**

```
jql_query = "project in (DEMO) AND status in ("in progress", Open)"
@jira.search.jqlquery(jql_query)

optional:
@jira.search.jqlquery(jql_query, return_fields, maxresults)
```

**Search by issue key**

```
@jira.search.issue "JRA-9"
```

**Get filter issues**

```
@jira.search.filter "12843"
```

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

```
gem 'jirarest'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install jira-rest
```

Usage
-----

```
require 'jira-rest'

@jira = JiraRest::Client.new(jira_host, username, password)
```

**Query by hash**

```
hash_query = {:project => 'DEMO', :status => '"in progress", Open'}
@jira.search.query_by_hash(hash_query)

optional:
@jira.search.query_by_hash(hash_query, return_fields, maxresults)
```

**Query by jql string**

```
jql_query = "project in (DEMO) AND status in ("in progress", Open)"
@jira.search.jqlquery(jql_query)

optional:
@jira.search.jqlquery(jql_query, return_fields, maxresults)
```

**Search by issue key**

```
@jira.search.issue "JRA-9"
```

**Get filter issues**

```
@jira.search.filter "12843"
```

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
