module Smsfly; class Config


  def self.from_file(path, opts={})
    config_values = self.parse_config_file(path)
    self.from_hash(config_values[:config], opts)
  end

  def self.parse_config_file(path)
    self.validate_path path
    contents = YAML.load_file(path)
    return {} unless contents
    self.symbolize_keys(contents)
  end



  private
  # Converts all hash keys to symbols (if a hash value is itself a hash, call the method recursively)
  #   Session.symbolize_keys({"one" => 1, "two" => {"foo" => "bar"}}) # => {:one => 1, :two => {:foo => "bar"}}
  def self.symbolize_keys(hash)
    hash.inject({}){|memo,(k,v)|
      unless v.class == Hash
        memo[k.to_sym] = v
      else
        memo[k.to_sym] = self.symbolize_keys(v)
      end
      memo
    }
  end

  def self.validate_path(path)
    raise "Invalid path: #{path}" unless File.exists? path
  end

end; end