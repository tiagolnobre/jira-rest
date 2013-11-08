require 'httparty'
require 'timeout'
 
class JiraRest

  def initialize jira_url, username, password
    @jira_url = jira_url + '/rest/api/latest/'
    @user =username
    @pass = password
    @auth = {:username => username, :password => password}
    
   end
   
  
  
  def get_issue issue_id
    
    url = @jira_url + 'issue/' + issue_id.to_s
    p url
    self.get url
  end  
  
  

  def get url, options={}
    options.merge!(:headers => {"Content-Type" => 'application/json'})
   # options.merge!({:basic_auth => @auth})
    
    rest = HTTParty.get(url, options)
    puts rest.code
    puts rest.message
    puts rest.body
  end  


  class Response
    attr_reader :success, :tickets, :optional

    def initialize(success, tickets, error_msg, optional=nil)
      @success = success
      @tickets = tickets
      @error_msg = error_msg
      @optional = optional
    end
  end
end
  