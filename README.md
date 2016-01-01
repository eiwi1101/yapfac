# YAPFAC: Yet Another Parser for Apache Configuration

[![Gem Version](https://badge.fury.io/rb/yapfac.svg)](https://badge.fury.io/rb/yapfac)
[![Build Status](https://travis-ci.org/eiwi1101/yapfac.svg)](https://travis-ci.org/eiwi1101/yapfac)
[![Code Climate](https://codeclimate.com/github/eiwi1101/yapfac/badges/gpa.svg)](https://codeclimate.com/github/eiwi1101/yapfac)
[![Test Coverage](https://codeclimate.com/github/eiwi1101/yapfac/badges/coverage.svg)](https://codeclimate.com/github/eiwi1101/yapfac/coverage)

YAPFAC provides a parser to read and write Apache configuration files. YAPFAC also provides a secure RESTful API for doing this remotely, providing seamless controll of a number of Apache servers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yapfac'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yapfac

## Configuration

Before using Yapfac, configure the gem in an initializer or some other useful place. The following are the default configuration options.

```ruby
Yapfac.configure do |config|

  # Apache Default Options
  config.apache_path = "/etc/apache2"
  config.sites_available_path = "sites-available"
  config.sites_enabled_path = "sites-enabled"

end
```

## Usage

```ruby
default = Yapfac::Apache::Site.new("/etc/apache2/sites-available/000-default.conf")
puts default.to_s #=> Converts the config back into Apache Config format.
puts default.to_h #=> Converts the config into a hash.

# This will dump all the sites available to your terminal
# As the re-generated Apache config and JSON pretty format.
#
Yapfac::Apache.sites_available.each do |site|
  v = Yapfac::Apache.load_site(site)

  puts "=" * 80
  puts v.name
  puts "-" * 80
  puts v.to_s
  puts "-" * 80
  puts JSON.pretty_generate v.to_h
end

# This will build and save a new basic site to your sites-available
# directory.
#
s = Yapfac::Apache.new_site('001-example.com') do |site|
  site.add_directive "DocumentRoot /var/www/example"

  site.add_scope "Directory", "/var/www/example" do |scope|
    scope.add_directive "Order", "allow,deny"
    scope.add_directive "Allow", "from", "all"
  end
end

s.save #=> Writes output to sites-available
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

For ease in testing, you can modify `bin/quicktest` to run through some real-world scenarios. (Currently, `bin/quicktest` requires apache2 to be installed.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eiwi1101/yapfac. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.

## Contact

This gem is maintained by William Eisert [weisert@eisertdev.com](mailto:weisert@eisertdev.com).
[![Buy me a coffee at ko-fi.com](https://az743702.vo.msecnd.net/cdn/btn1.png)](https://ko-fi.com?i=15867V22TVFEL)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

