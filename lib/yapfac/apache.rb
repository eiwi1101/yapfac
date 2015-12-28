# Load Apache deps
require 'yapfac/apache/directive'
require 'yapfac/apache/scope'
require 'yapfac/apache/site'
#require 'yapfac/apache/directive'

# Autoload Directives

module Yapfac
class Apache

  def initialize
  end

  def self.sites_available
    Dir[File.join(Yapfac.configuration.apache_path, Yapfac.configuration.sites_available_path, '*.conf')]
  end

  def self.sites_enabled
    Dir[File.join(Yapfac.configuration.apache_path, Yapfac.configuration.sites_enabled_path, '*.conf')]
  end

end
end
