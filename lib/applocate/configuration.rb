module Applocate
  class Configuration
    attr_accessor :token
    attr_accessor :secret
    attr_accessor :base_url

    def initialize
      @token = ENV["APPLOCATE_TOKEN"]
      @secret = ENV["APPLOCATE_SECRET"]
      @base_url = ENV["APPLOCATE_BASE_URL"] || "https://www.applocate.com"
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
