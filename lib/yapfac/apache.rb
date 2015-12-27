# Load Apache deps
require 'yapfac/apache/scope'
require 'yapfac/apache/site'
#require 'yapfac/apache/directive'

# Autoload Directives

module Yapfac
class Apache

  attr_reader :sites_available

  def initialize
    @sites_available = get_sites
  end

private

  # Builds a list of Yapfac::Apache::Site objects based on
  # the default Apache sites_available directory.
  #
  def get_sites
    sites = Hash.new
    files = Dir['/etc/apache2/sites-available/*.conf']
    
    files.each do |file|
      name = File.basename(file, '.conf')
      sites.store(name, Yapfac::Apache::Site.new(file))
    end

    return sites
  end

end
end
