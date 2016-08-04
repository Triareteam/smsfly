module Smsfly
  module Generators
    class ConfigGenerator < Rails::Generators::Base
      desc 'Creates a Smsfly gem configuration file at config/smsfly.yml'

      def self.source_root
        @_smsfly_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def create_config_file
        template 'smsfly.yml', File.join('config', 'smsfly.yml')
      end

    end
  end
end