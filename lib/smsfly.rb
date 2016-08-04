require 'smsfly/version'
require 'smsfly/config'
require 'net/http'
require 'uri'

module Smsfly
  extend Config
  def self.send
    puts "Sms send!"
  end
end
