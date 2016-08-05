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
      return true
    else
      puts  'Incorrect login'
      puts  'Login must be like 380675807873'
      puts  'Please configure this file  config/initializers/smsfly.rb'
      return false
    end
  end



  def self.test_sms(text , recipient)

    description = 'Smsfly Test Message'
    start_time = 'AUTO'
    end_time = 'AUTO'
    rate = 1
    lifetime = 4
    source = 'SMS'
    xml_string = <<XML
      <?xml version="1.0" encoding="utf-8"?>
      <request>
      <operation>SENDSMS</operation>
      <message start_time="#{start_time}" end_time="#{end_time}" lifetime="#{lifetime}" rate="#{rate}" desc="'#{description}" source="#{source}">
      <body>Smsfly Test Text - #{text}</body>
      <recipient>#{recipient}</recipient>
      </message>
      </request>
XML

    full_url = "http://sms-fly.com/api/api.php"
    uri = URI.parse(full_url)
    headers = {'Content-Type' => "text/xml", 'Accept' => "text/xml" }
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, headers)
    request.basic_auth login, password
    request.body = xml_string
    response = http.request(request)
    puts response.code
    puts response.body
  end

end
