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
    Dir[File.join(Yapfac.configuration.apache_path, Yapfac.configuration.sites_available_path, '*.conf')].collect { |f| File.basename(f, '.conf') }
  end

  def self.sites_enabled
    Dir[File.join(Yapfac.configuration.apache_path, Yapfac.configuration.sites_enabled_path, '*.conf')].collect { |f| File.basename(f, '.conf') }
  end

  def self.load_site(site_name)
    file = File.join(Yapfac.configuration.apache_path, Yapfac.configuration.sites_available_path, site_name + '.conf')

    return nil unless File.exists? file
    return Yapfac::Apache::Site.load(file)
  end

  def self.new_site(site_name)
    site = Yapfac::Apache::Site.new(site_name)
    yield  site
    return site
  end

end
end
