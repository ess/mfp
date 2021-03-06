# MFP #

The goal of the MFP (Minimally-Functional Programming) gem is to bring some of the goodness of [dry-rb](https://dry-rb.org) to older versions of Ruby. That being the case, dry-rb is a ***MUCH*** more thorough solution, and if you aren't constrained to incredibly outdated Ruby versions, I would implore you to use it instead of this.

## Installation ##

Add this line to your application's Gemfile:

```ruby
gem 'mfp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mfp

## Usage

MFP includes minimally-viable implementeations of the `Result` concept from more functional languages as well as a mechanism for doing [Railway Oriented Programming](https://fsharpforfunandprofit.com/rop/). These map to the same ideas as `Dry::Monads::Result` and `Dry::Transaction`, but are not really proper FP implementations.

### Result ###





### Railway Oriented Programming ##

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ess/mfp.

As this project uses [git-flow](https://nvie.com/posts/a-successful-git-branching-model/), please base any contributions you wish to make on the "develop" branch.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
