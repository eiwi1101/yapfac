module Yapfac
class  Apache
class  Directive

  attr_accessor :name, :params

  # Initialize a new Directive, given an array and arbitrary number of params.
  #
  # @param [String] name    The directive name (DocumentRoot, etc.)
  # @param [Array]  *params Any number of parameters for the directive.
  #
  def initialize(name, *params)
    @name   = name
    @params = params
  end

  # Parses a directive string into a directive object. This is most often used
  # when reading in from a file.
  #
  # @param [String] name   The directive name (DocumentRoot, etc.)
  # @param [String] params A string of directive parameters to parse.
  #
  # @overload parse(line)
  #   @param [String] line The full directive line to parse, with or without
  #                   params.
  #
  # @return [Yapfac::Apache::Directive] New and parsed directive instance.
  #
  # @example Known Name
  #   d = Yapfac::Apache::Directive.parse("DocumentRoot", "/www/html")
  #
  # @example Full Line Parse
  #   d = Yapfac::Apache::Directive.parse("DocumentRoot /www/html")
  #
  # @example Parse Multiple Params
  #   # The real purpose of this method.
  #   d1 = Yapfac::Apache::Directive.parse("Deny from all")
  #   d2 = Yapfac::Apache::Directive.parse("Deny", "from all")
  #
  #   # d1.params == d2.params == ["from", "all"]
  #
  def self.parse(name, params = nil)
    name, params = name.split /\s+/, 2 if params.nil?
    return Yapfac::Apache::Directive.new(name, *parse_params(params))
  end

  # Builds a string representation of the directive, which is valid for
  # storing in an Apache configuration file.
  #
  # @return [String] String representation of Apache Directive
  #
  def to_s
    "#{@name} #{@params.collect do |p|
      if p =~ /\s/
        "\"#{p}\""
      else
        p
      end
    end.join(' ')}"
  end

  # Builds a hash representation of the Apache Directive, useful for
  # serialization.
  #
  # @return [Hash] A hash with +:name+ (String) and +:params+ (array) keys.
  #
  # @example Hashify an Apache Directive
  #   d = Yapfac::Apache::Directive.parse("Deny from all")
  #   d.to_h #=> { name: "Deny", params: [ "from", "all" ] }
  #
  def to_h
    return ({
      name: @name,
      params: @params
    })
  end

private

  # Tokenizes params, keeping quoted values together.
  # @param [String] params Params string to tokenize
  # @return [Array] Tokenized params
  #
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
