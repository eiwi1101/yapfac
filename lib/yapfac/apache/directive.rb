module Yapfac
class  Apache
class  Directive

  attr_accessor :name, :params

  def initialize(name, params = nil)
    @name   = name
    @params = parse(params)
  end

  def to_s
    "#{@name} #{@params.join(' ')}"
  end

private

  def parse(params)
    return Array.new if params.nil?

    return params.
      split(/\s(?=(?:[^'"]|'[^']*'|"[^"]*")*$)/).
      select { |s| not s.empty? }.
      map    { |s| s.gsub(/(^\s+)|(\s+$)|(^["']+)|(["']+$)/, '') }
  end

end
end
end
