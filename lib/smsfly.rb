require 'smsfly/version'
require 'smsfly/logger'
require 'helpers/configuration'
require 'net/http'
require 'uri'

module Smsfly

  extend Configuration
  define_setting :login
  define_setting :password
  define_setting :login, 'Please configure this file  /config/initializers/smsfly.rb'
  define_setting :password, 'Please configure this file  /config/initializers/smsfly.rb'

  class << self
    delegate :debug, to: ::Smsfly::Logger
  end

  def self.connect_info

    if Smsfly.login.length == 12
      debug 'You login:' "#{Smsfly.login}"
      debug 'You password:' "#{Smsfly.password}"
      return true
    else
      debug  'Incorrect login'
      debug  'Login must be like 380675807873'
      debug  'Please configure this file  /config/initializers/smsfly.rb'
      return false
    end
  end

  def self.colorize(text, color = "default", bgColor = "default")
    colors = {"default" => "38","black" => "30","red" => "31","green" => "32","brown" => "33", "blue" => "34", "purple" => "35",
              "cyan" => "36", "gray" => "37", "dark gray" => "1;30", "light red" => "1;31", "light green" => "1;32", "yellow" => "1;33",
              "light blue" => "1;34", "light purple" => "1;35", "light cyan" => "1;36", "white" => "1;37"}
    bgColors = {"default" => "0", "black" => "40", "red" => "41", "green" => "42", "brown" => "43", "blue" => "44",
                "purple" => "45", "cyan" => "46", "gray" => "47", "dark gray" => "100", "light red" => "101", "light green" => "102",
                "yellow" => "103", "light blue" => "104", "light purple" => "105", "light cyan" => "106", "white" => "107"}
    color_code = colors[color]
    bgColor_code = bgColors[bgColor]
    return "\033[#{bgColor_code};#{color_code}m#{text}\033[0m"
  end

  def self.authentication?
    xml_string = <<XML
      <?xml version="1.0" encoding="utf-8"?>
      <request>
      <operation>GETBALANCE</operation>
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
    if response.body.to_s == 'Access denied!'
      debug   "#{colorize('#############################', "red", "red")}"
      debug   "#{colorize('#', "red", "red")}"+"#{colorize('Incorrect Login or Password', "red")}"+ "#{colorize('#', "red", "red")}"
      debug   "#{colorize('#############################', "red", "red")}"
      return false
    else
      debug   "#{colorize('###########################', "green" , "green")}"
      debug  "#{colorize('#', "green", "green")}"+ "#{colorize('Successful Authentication', "green")}"+ "#{colorize('#', "green", "green")}"
      debug   "#{colorize('###########################', "green" , "green")}"
      return true
    end

  end

  def self.balance
    if  !self.authentication?
      debug   "#{colorize('#############################', "red", "red")}"
      debug   "#{colorize('#', "red", "red")}"+"#{colorize('Incorrect Login or Password', "red")}"+ "#{colorize('#', "red", "red")}"
      debug   "#{colorize('#############################', "red", "red")}"
      return false
    else
      xml_string = <<XML
      <?xml version="1.0" encoding="utf-8"?>
      <request>
      <operation>GETBALANCE</operation>
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
      balance =  response.body.match(/<balance>(.*)<\/balance>/)[1]
      debug "#{colorize('##', "red", "red")}"+"#{colorize("You balance: #{balance}  UAH",  "red")}"+"#{colorize('##', "red", "red")}"
      return balance.to_f
    end
  end

  def self.test_sms(text)
    recipient = Smsfly.login
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
    debug response.code
    debug response.body
  end


  def self.send_sms(text, recipient)
    description = 'Smsfly'
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
      <body>#{text}</body>
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
    debug response.body
  end

end
