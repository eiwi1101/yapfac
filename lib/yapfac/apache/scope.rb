module Yapfac
class  Apache
class  Scope

  attr_reader :directives
  attr_reader :scopes

  attr_accessor :parent
  attr_accessor :name
  attr_accessor :params

  def initialize(name = nil, params = nil, parent = nil)
    @name   = name
    @params = params.nil? ? Array.new : params.split(/\s+/)
    @parent = parent

    @directives = Array.new
    @scopes     = Array.new
  end

  def add_directive(directive, *params)
    if directive.kind_of? Yapfac::Apache::Directive
      @directives.push(directive)
    else
      @directives.push(Yapfac::Apache::Directive.new(directive, *params))
    end
  end

  def add_scope(scope, *params)
    if scope.kind_of? Yapfac::Apache::Scope
      if scope == self
        raise "Scope can not be a child of itsself."
      end

      scope.parent = self
      @scopes.push(scope)
    else
      scope = Yapfac::Apache::Scope.new(scope, *params, self)
      @scopes.push(scope)
    end

    if block_given?
      yield scope
    end
  end

  def to_h
    return({
      name: @name,
      params: @params,
      directives: @directives.collect(&:to_h),
      scopes: @scopes.collect(&:to_h)
    })
  end

  def to_s
    # TODO: Figure out a cleaner indentation method.

    out = Array.new
    tab = @parent.nil? ? "" : "\t"

    unless self.kind_of? Yapfac::Apache::Site
      out << "<#{@name} #{@params.join(' ')}>"
    end

    unless @directives.empty?
      out << @directives.collect { |d| d.to_s.prepend(tab) }
    end

    unless @scopes.empty?
      out << @scopes.collect { |s| s.to_s.split("\n").collect { |v| v.prepend(tab) }.join("\n") }
    end

    unless self.kind_of? Yapfac::Apache::Site
      out << "</#{@name}>"
    end

    return out.join("\n")
  end

end
end
end
