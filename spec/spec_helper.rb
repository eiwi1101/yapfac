$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec/collection_matchers'

# CodeClimate Test Coverage
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

# Begin Local Things
require 'yapfac'

class Fuubar
  DEFAULT_PROGRESS_BAR_OPTIONS[:format] = ' %c/%C [%w >:| %i] %e '
end
