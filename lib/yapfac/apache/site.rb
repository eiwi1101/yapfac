module Yapfac
class  Apache
class  Site < Scope

  def initialize(filename)
    super()
    @name = File.basename(filename, '.conf')
    @config_lines = read_file(filename)
    parse!
  end

private

  def read_file(filename)
    lines = File.read(filename)
    lines.gsub!("\\\n", '')

    lines_a = lines.split("\n").map(&:strip!)
    lines_a.reject! { |l| l =~ /^\s*(?:#.*)?$/ }
    lines_a.reject! &:nil?
    lines_a.map     { |l| l.gsub! /\s+/, ' ' }

    return lines_a
  end

  def parse!
    scope = self

    @config_lines.each do |line|
      # Enter Child Scope
      if line =~ /^<(\w+)\s*(.*)?>$/
        new_scope = Yapfac::Apache::Scope.new($1, $2, scope)
        scope.add_scope(new_scope)
        scope = new_scope

      # Exit Child Scope
      elsif line =~ /^<\/#{scope.name}>$/
        scope = scope.parent

      # Add Directive
      elsif line =~ /^(\w+)\s*(.*)$/
        directive = Yapfac::Apache::Directive.new($1, $2)
        scope.add_directive(directive)
      end
    end
  end

end
end
end
