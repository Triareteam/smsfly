# Smsfly

Welcome! 
 This Ruby gem  helps You to send SMS using API https://sms-fly.com/

TODO: 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smsfly', '~> 0.4.3'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smsfly


Then run:

    $ rails g smsfly:config

which will generate default settings files:

    config/initializers/smsfly.rb

Then configurate smsfly.rb file:

```ruby
Smsfly.configuration do |config|
  config.login = 'You login' # Like this 380675807873
  config.password = 'You password' # Like this  ZhHtgj4Z
end
```

Test connection to API:

```ruby
Smsfly.authentication?
#this return
true #- If authentication is successful 
false #- If authentication failed
```

Get your balance:

```ruby
Smsfly.balance
#this return
Float object(like "6.177" ,"5.655")#- If authentication is successful 
false #- If authentication failed
```

## Usage

TODO: 

For show you login and password run:

    $ rails c
    $ Smsfly.connect_info

If the file *smsfly.rb* is set up correctly 
You can send a test message to your own login/phone

```ruby
Smsfly.test_sms('You random text')
```


To send a message to other numbers, use

```ruby
Smsfly.send_sms(text, recipient)  #  For example Smsfly.send_sms('Hellow Word', '380675807873')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Serhii-Danovsky/smsfly. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

