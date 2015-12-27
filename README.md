# YAPFAC: Yet Another Parser for Apache Configuration

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

## Usage

```ruby
local_server = Yapfac.new
local_server.sites_available #=> ["000-default.conf", "something.conf"]

begin
  remote_server = Yapfac.new('some.host.example.com')
  remote_server.a2ensite('000-default.conf')
rescue Yapfac::ConnectionError => e
  puts "Unable to connect to #{e.hostname}: #{e.message}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eiwi1101/yapfac. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

