require 'httparty'
require 'timeout'
 
class JiraRest
  
  attr_reader :next_version, :actual_version, :token, :client, :all_versions #, :operations_available

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
  
  def get_versions project_key
    all_versions = []
    version_name =[]
    hash_versions = {}
    time = Time.now.strftime("%F")
    url = @jira_url + "project/#{project_key}/versions?expand"
    p url
    resp = self.get url
    
    resp.each do |version_array| 
      not_nil = !(version_array['releaseDate'].is_a? NilClass) 
        version_name << version_array['name'] if  not_nil and time <= Time.parse(version_array['releaseDate']).strftime("%F")
        hash_versions.store(version_array['name'], version_array['releaseDate'])
     
      all_versions << version_array['name']
    end  
        
        
    @all_versions = all_versions.sort_by { |a| a.split('.').map &:to_i }
    @actual_version = version_name.empty? ? @all_versions[@all_versions.index(hash_versions.sort_by { |k, v| v }.last[0]) + 1] : version_name.sort_by { |a| a.split('.').map &:to_i }.first

    # in case there is no next_version put the last two version of the array of versions
    if @actual_version.nil?
      @next_version = @all_versions[-1]
      @actual_version = @all_versions[-2]
    else
      @next_version = @all_versions[@all_versions.index(@actual_version) + 1]
      # if there is no next version put the last two versions
      if @next_version.nil?
        @next_version = @all_versions[-1]
        @actual_version = @all_versions[-2]
      end
    end
      raise Exceptions::CouldNotGetNextVersion, 'Problem getting Next Version number' if @next_version.nil?
      raise Exceptions::CouldNotGetActualVersion, 'Problem getting Actual Version number' if @actual_version.nil?
      return true
  end  

  def get url, options={}
    options.merge!(:headers => {"Content-Type" => 'application/json'})
   # options.merge!({:basic_auth => @auth})
    
    rest = HTTParty.get(url, options)
    puts rest.code
    #puts rest.message
    #puts rest.body
    
    return rest
#    {"self":"https://jira.atlassian.com/rest/api/latest/version/10130","id":"10130","name":"0.6.8","archived":true,"released":true,"projectId":10240}
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
  