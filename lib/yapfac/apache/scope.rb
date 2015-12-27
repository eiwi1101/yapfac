module Yapfac
class  Apache
class  Scope

  attr_reader :name, :params, :parent

  def initialize(name = nil, params = nil, parent = nil)
    @name   = name
    @params = params.nil? ? Array.new : params.split(/\s+/)
    @parent = parent

    @directives = Array.new
    @scopes     = Array.new
  end

  def add_directive(line)
    @directives.push(line)
  end

  def add_scope(scope)
    if scope == self
      raise "Scope can not be a child of itsself."
    end

    @scopes.push(scope)
  end

  def to_s
    # TODO: Figure out a cleaner indentation method.

    out = Array.new
    tab = @parent.nil? ? "" : "\t"

    unless name.nil?
      out << "<#{@name} #{@params.join(' ')}>"
    end

    unless @directives.empty?
      out << @directives.collect { |d| d.to_s.prepend(tab) }
    end

    unless @scopes.empty?
      out << @scopes.collect { |s| s.to_s.split("\n").collect { |v| v.prepend(tab) }.join("\n") }
    end

    unless name.nil?
      out << "</#{@name}>"
    end

    return out.join("\n")
  end

end
end
end
