require 'rubygems'
require 'net/http'
require 'net/https'
require 'uri'
require 'json'

class AirSet
  def initialize(app_id, secret_key, session_key=nil)
    @uri = URI.parse('https://www.airset.com/services/rpc')
    @app_id = app_id
    @secret_key = secret_key
    @key = session_key
    @request_id = 0
  end
  
  def create_token(return_url = nil)
    call 'auth.createToken', 
      'appId'            => @app_id,
      'appSecretKey'     => @secret_key,
      'postApprovalLink' => return_url
  end
  
  def create_session(auth_token)
    call 'auth.getSession',
      'appId'        => @app_id,
      'appSecretKey' => @secret_key,
      'authToken'    => auth_token
  end
  
  def load_table(table)
    call 'db.load', 'table' => table
  end
  
  def user_name
    call 'user.getName'
  end
  
  private
  
  def call(method, args = {})
    http = Net::HTTP.new(@uri.host, @uri.port)
    http.use_ssl = true
    @request_id += 1
    
    path = @uri.path
    unless @key.blank?
      path += "?key=#{@key}"
    else
      path += "?key="
    end
    
    result = http.post(path, [{:method => method.to_s, :params => [args], :id => @request_id}].to_json).body.to_s
    JSON.parse(result[3..-4]).first['result']
  end
end
