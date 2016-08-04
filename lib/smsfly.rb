require 'smsfly/version'
require 'helpers/configuration'
require 'net/http'
require 'uri'

module Smsfly

  extend Configuration
  define_setting :login
  define_setting :password

  def self.test
    puts 'You login:' + Smsfly.login
    puts 'You password:'  +Smsfly.paswword
  end
end
