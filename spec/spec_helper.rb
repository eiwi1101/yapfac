$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'codeclimate-test-reporter'
require 'yapfac'

CodeClimate::TestReporter.start

class Fuubar
  DEFAULT_PROGRESS_BAR_OPTIONS[:format] = ' %c/%C [%w >:| %i] %e '
end
