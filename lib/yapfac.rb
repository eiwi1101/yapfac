require "yapfac/version"
require "yapfac/apache"

module Yapfac
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configuration=(configuration)
    @configuration = configuration
  end

  def self.configure
    yield configuration
  end

  class Configuration
    attr_accessor :apache_path
    attr_accessor :sites_available_path
    attr_accessor :sites_enabled_path

    def initialize
      @apache_path = "/etc/apache2"
      @sites_available_path = "sites-available"
      @sites_enabled_path = "sites-enabled"
    end

    def reset!
      initialize
    end
  end
end
