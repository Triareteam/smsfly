require 'smsfly/version'
require 'helpers/configuration'
require 'smsfly/connection'
require 'net/http'
require 'uri'

module Smsfly

  extend Configuration
  define_setting :login
  define_setting :password
  define_setting :login, 'Please configure this file  config/initializers/smsfly.rb'
  define_setting :password, 'Please configure this file  config/initializers/smsfly.rb'

  def self.test
    include Connection
    test_connection
  end
end
