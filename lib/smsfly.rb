require 'smsfly/version'
require 'helpers/configuration'
require 'net/http'
require 'uri'

module Smsfly

  extend Configuration
  define_setting :login
  define_setting :password
  define_setting :login, 'Please configure this file  config/initializers/smsfly.rb'
  define_setting :password, 'Please configure this file  config/initializers/smsfly.rb'

  def self.test_connection

    if Smsfly.login.length == 12
      puts 'You login:' "#{Smsfly.login}"
      puts 'You password:' "#{Smsfly.password}"
      connection(Smsfly.login,Smsfly.password)
    else
      puts  'Incorrect login'
      puts  'Login must be like 380675807873'
      puts  'Please configure this file  config/initializers/smsfly.rb'
    end
  end



  def connection(login,password)
    full_url = "http://sms-fly.com/api/api.php"
    uri = URI.parse(full_url)
    headers = {'Content-Type' => "text/xml", 'Accept' => "text/xml" }
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.basic_auth login, password
    response = http.request(request)
    puts response.code
    puts response.body
  end

end
