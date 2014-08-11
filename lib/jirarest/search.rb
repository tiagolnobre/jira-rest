module JiraRest
  class Search
    Url = Struct.new(:jql, :fields, :maxresults)

    def initialize(params)
      @token = params.token
    end


    def issue(issue_id)
      url = 'issue/' + issue_id.to_s
      issue = Url.new
      issue.fields = 'key,summary,issuetype,reporter,priority'
      search_url = Client.construct_url @token.url + url, issue
      response = Client.get search_url, @token.header
      Client.handle_response(response, nil, true)
      #TODO parse issue result
    end

    #get tickets from filter id
    #
    # @param[Integer/String] if filter id
    # @return[JiraRest::Response]
    def filter(id)
      url = 'filter/' + id.to_s
      issue = Url.new
      issue.fields = 'key,summary,issuetype,reporter,priority'
      search_url = Client.construct_url @token.url + url, issue
      response = Client.get search_url, @token.header
      filter_url = Client.handle_response(response, 'searchUrl')
      return filter_url unless filter_url.success
      filter_response = Client.get filter_url.body, @token.header
      Client.handle_response(response, nil, true)
    end


    #get tickets by hash
    #
    # @param[Hash] hash_tickets - verify,in progress, open, reopened, closed
    # @param[String] return_fields default will be 'key,summary'
    # @param[String] maxresults max number of results default will be 300
    # @return[JiraRest::Response]
    def query_by_hash(hash_tickets, return_fields=nil, maxresults=nil)
      jql_string = hash_tickets.map { |k, v| "#{k} in (#{v})" }.join(' AND ')
      search_url = Client.construct_url('search', Url.new(URI.encode(jql_string), return_fields, maxresults))
      response = Client.get @token.url + search_url, @token.header
      Client.handle_response(response, nil, true)
    end

    #get tickets from by a jql query
    #
    # @param[String] jql_string - jql string
    # @param[String] return_fields default will be 'key,summary'
    # @param[String] maxresults max number of results default will be 300
    # @return[JiraRest::Response]
    def jqlquery(jql_string, return_fields=nil, maxresults=nil)
      search_url = Client.construct_url('search', Url.new(URI.encode(jql_string), return_fields, maxresults))
      response = Client.get @token.url + search_url, @token.header
      Client.handle_response(response, nil, true)
    end
  end
end
