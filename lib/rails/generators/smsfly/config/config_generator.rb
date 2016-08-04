module Smsfly
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc 'Creates a Smsfly gem configuration file at config/smsfly.yml'

      def self.source_root
        @_smsfly_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_initializer_file
        template 'initializer.rb', File.join('config', 'initializers', 'smsfly.rb')
        puts 'Configure file was created!'
        puts 'Please configure this file  config/initializers/smsfly.rb'
      end

     # def create_config_file
     #   template 'smsfly.yml', File.join('config', 'smsfly.yml')
     # end

    end
  end
end