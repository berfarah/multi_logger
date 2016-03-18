# MultiLogger

This is a quick and dirty solution to writing out multiple files / stdout with
an extensible format that allows for more formatting and logging options

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multi_logger', git: 'https://github.com/berfarah/multi_logger.git'
```

And then execute:

    $ bundle

## Usage

```ruby
# You can set up a new multilogger with a default level, max-size and max-files
logger = MultiLogger.new(level: :info, max_size: 5_000, max_files: 5)


# Not required, but allowed, is the ability to instantiate multiple loggers
# immediately
logger = MultiLogger.new(level: :info, max_size: 5_000, max_files: 5,
                         loggers: [
                           { name: :stdout, location: $stdout, logger: :stdout }
                          ])

# It's also possible to add additional loggers
logger.add name: :debug, location: "/path/to/debug.log" # logger: :default => File logger

logger.info "Hello world"
# => Writes to all logs

logger.debug "Foo bar"
# => Writes to all debug logs
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/berfarah/multi_logger. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
