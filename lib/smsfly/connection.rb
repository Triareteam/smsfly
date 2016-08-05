module Smsfly

  module Connection

    def test_connection
      puts 'test_connection:' "#{Smsfly.login}"
      puts 'test_connection:' "#{Smsfly.password}"
    end

  end
end