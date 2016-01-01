module Yapfac
class  Apache
class  Site < Scope

  attr_reader :config_lines

  def initialize(site_name)
    super(site_name)
  end

  def self.load(filename)
    s = Yapfac::Apache::Site.new(File.basename(filename, '.conf'))
    s.load_file(filename)
    s.parse!
    return s
  end

  def load_file(filename)
    lines = File.read(filename)
    lines.gsub!("\\\n", ' ')
    lines_a = lines.split("\n").map(&:strip)
    lines_a.reject! { |l| l =~ /^\s*#.*$/ }
    lines_a.reject! &:nil?
    lines_a.map     { |l| l.gsub! /\s+/, ' ' }

    @config_lines = lines_a
  end

  def parse!
    scope = self

    @config_lines.each do |line|
      puts line

      # Enter Child Scope
      if line =~ /^<(\w+)\s*(.*)?>$/
        new_scope = Yapfac::Apache::Scope.new($1, $2, scope)
        scope.add_scope(new_scope)
        scope = new_scope
        puts "Scope Enter #{new_scope.name} from #{self.name}"

      # Exit Child Scope
      elsif line =~ /^<\/#{scope.name}>$/
        scope = scope.parent
        puts "Scope Exit #{scope.name} from #{self.name}"

      # Add Directive
      elsif line =~ /^(\w+)\s*(.*)$/
        directive = Yapfac::Apache::Directive.parse($1, $2)
        scope.add_directive(directive)
        puts "Scope Directive #{directive.name} from #{self.name}"
      end
    end
  end

end
end
end
