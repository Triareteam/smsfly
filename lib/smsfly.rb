require 'smsfly/version'
require 'helpers/configuration'
require 'net/http'
require 'uri'

module Smsfly

  extend Configuration
  define_setting :login
  define_setting :password
  define_setting :login, "Please configure this file  config/initializers/smsfly.rb"
  define_setting :password, "Please configure this file  config/initializers/smsfly.rb"

  def self.test
    puts 'You login:' "#{Smsfly.login}"
    puts 'You password:' "#{Smsfly.password}"
  end
end
