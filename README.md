# YAPFAC: Yet Another Parser for Apache Configuration

[![Gem Version](https://badge.fury.io/rb/yapfac.svg)](https://badge.fury.io/rb/yapfac)
[![Build Status](https://travis-ci.org/eiwi1101/yapfac.svg)](https://travis-ci.org/eiwi1101/yapfac)

YAPFAC provides a parser to read and write Apache configuration files. YAPFAC also provides a secure RESTful API for doing this remotely, providing seamless controll of a number of Apache servers.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yapfac', git: 'eiwi1101/yapfac'
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

sites = Yapfac::Apache.sites_available
puts sites.first.to_s #=> Dumps the configuration file for the first site in sites-available

online = Yapfac::Apache.sites_enabled #=> Just reads the sites-enabled dir.

### COMING SOON

Yapfac::Apache.a2ensite  "example.com.conf" #=> Enables site
Yapfac::Apache.a2dissite "000-default.conf" #=> Disables site

# Self-explanatory
Yapfac::Apache.reload
Yapfac::Apache.restart

Yapfac::Apache.a2ensite! "example.com.conf" #=> Enables site and reloads Apache. Same for ::a2dissite.
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

For ease in testing, you can modify `bin/quicktest` to run through some real-world scenarios. (Currently, `bin/quicktest` requires apache2 to be installed.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eiwi1101/yapfac. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

