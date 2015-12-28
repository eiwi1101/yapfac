$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'yapfac'

class Fuubar
  DEFAULT_PROGRESS_BAR_OPTIONS[:format] = ' %c/%C [%w >:| %i] %e '
end
