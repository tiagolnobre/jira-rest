module JiraRest

  class Client
    DEFAULT_FIELDS = 'key,summary'
    MAXRESULTS = '300'

    attr_accessor :token

    Token = Struct.new(:url, :header)
    Response = Struct.new(:success, :body, :error_msg, :optional)

    def initialize(jira_host, username=nil, password=nil)

      jira_url = "#{jira_host}/rest/api/latest/"

      generate jira_url, username, password

    end

    def generate(url, username=nil, password=nil)
      header = {'Content-Type' => 'application/json'}
      header['Authorization'] = "Basic #{Base64.strict_encode64(username+':'+password)}" unless username.nil? and password.nil?
      @token = Token.new(url, header)
    end


    def search
      JiraRest::Search.new(self)
    end


    def self.get(url, header)
      begin
        p "Url: #{url}"
        HTTParty.get(url, header)
      rescue Exception::ArgumentError => e
        p e + "/n #{url}"
        return false
      end
    end




    def self.construct_url(endpoint, params)
      p "Query: #{params.jql}" unless params.jql.nil?
      params.fields = DEFAULT_FIELDS if (params.fields.nil? or params.fields.to_s.empty?)
      params.maxresults = MAXRESULTS if (params.maxresults.nil? or params.maxresults.to_s.empty?)

      endpoint + '?' + encode_www_form(params.to_h.delete_if { |k, v| v.nil? }).to_s
    end

    def self.encode_www_form(enum)

      enum.map do |k, v|
        if v.nil?
          URI.encode_www_form_component(k)
        elsif v.respond_to?(:to_ary)
          v.to_ary.map do |w|
            str = URI.encode_www_form_component(k)
            unless w.nil?
              str << '='
              str << w
            end
          end.join('&')
        else
          str = URI.encode_www_form_component(k)
          str << '='
          str << v.to_s
        end
      end.join('&')
    end

    #TODO refactor to use in all methods
    def self.handle_response(response, key=nil)
      raise ArgumentError, 'Response is not a HTTParty::Response' unless response.class == HTTParty::Response
      case response.code
        when 200
          parsed_response = key.nil? ? response.parsed_response : response.parsed_response[key]
          return Response.new(true, parsed_response, nil)
        when (400..499)
          msg = response['errorMessages'].nil? ? response.code : response['errorMessages'].join("\n")
          return Response.new(false, response.response.message, msg)
        else
          return Response.new(false, nil, 'fail')
      end
    end

    def self.parse_search_result(response, fields=nil)
      code = response.code
      response = response.parsed_response
      case code
        when 200
          jira_tickets = []
          if response.has_key? 'issues'
            response['issues'].each do |tickets|
              if !tickets['key'].nil? and !tickets['fields']['summary'].nil?
                jira_tickets << [tickets['key'], tickets['fields']['summary'], tickets['self']]
              end
            end
          elsif !fields.nil?
            sss = ""
             fields.split(',').each {|field|
                p field  if response[field]
                sss << response[field]  if response[field]

             }
                p sss
          end
          return Response.new(true, jira_tickets.sort_by { |x| x.first }, nil)
        when (400..499)
          msg = response['errorMessages'].nil? ? code : response['errorMessages'].join("\n")
          return Response.new(false, nil, msg)
        else
          return Response.new(false, nil, 'fail')
      end
    end


  end
end