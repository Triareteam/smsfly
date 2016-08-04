module Smsfly; class Config

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :login
    attr_accessor :password

    def initialize
      @login= 'test-login'
      @password =  'test-password'
    end
  end
end; end