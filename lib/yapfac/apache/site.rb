module Yapfac
class  Apache
class  Site < Scope

  def initialize(filename)
    super()

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
      if line =~ /^<(\w+)\s*(.*)?>$/
        new_scope = Yapfac::Apache::Scope.new($1, $2, scope)
        scope.add_scope(new_scope)
        scope = new_scope

      elsif line =~ /^<\/#{scope.name}>$/
        scope = scope.parent

      else
        scope.add_directive(line)
      end
    end
  end

end
end
end
