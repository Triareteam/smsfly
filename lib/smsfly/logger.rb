module Smsfly
  class Logger
    def self.debug msg
      if Object.const_defined?('Rails')
        Rails.logger.debug msg
      end

      puts msg if ENV['DEBUG'] != nil
    end
  end
end
