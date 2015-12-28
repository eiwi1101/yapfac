module Yapfac
class  Apache
class  Directive

  attr_accessor :name, :params

  def initialize(name, *params)
    @name   = name
    @params = params
  end

  def self.parse(name, params = nil)
    name, params = name.split /\s+/, 2 if params.nil?
    return Yapfac::Apache::Directive.new(name, *parse_params(params))
  end

  def to_s
    "#{@name} #{@params.collect do |p|
      if p =~ /\s/
        "\"#{p}\""
      else
        p
      end
    end.join(' ')}"
  end

  def to_h
    return ({
      name: @name,
      params: @params
    })
  end

private

  def self.parse_params(params = nil)
    return Array.new if params.nil?

    return params.
      split(/\s(?=(?:[^'"]|'[^']*'|"[^"]*")*$)/).
      select { |s| not s.empty? }.
      map    { |s| s.gsub(/(^\s+)|(\s+$)|(^["']+)|(["']+$)/, '') }
  end

end
end
end
