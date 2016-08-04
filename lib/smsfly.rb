require 'smsfly/version'
require 'helpers/configuration'
require 'net/http'
require 'uri'

module Smsfly

  extend Configuration

  define_setting :access_token
  define_setting :access_secret

  define_setting :favorite_liquid, "apple juice"
  define_setting :least_favorite_liquid, "seltzer water"


  def self.send
    puts "Sms send!"
  end
end
