# Applocate

This gem provides access to the Applocate API.

[![Build Status](https://travis-ci.org/aai/applocate.svg?branch=master)](https://travis-ci.org/aai/applocate)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'applocate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install applocate

## Usage

The Applocate gem will allow you to register devices with Applocate and then allow you to
push down restrictions profiles, app installations.

In order to access the API you will require a private token and a key.

You can set them as ENV variables ```APPLOCATE_TOKEN``` and ```APPLOCATE_SECRET``` or you can specify them in your
config as an initializer file. If you are connecting to a private Applocate server you can specify the base URL of
the server with ```APPLOCATE_BASE_URL```

```ruby
#/config/initializers/applocate.rb

Applocate.configure do |config|
  config.token = ENV['APPLOCATE_TOKEN']
  config.secret = ENV['APPLOCATE_SECRET']
end
```

Currently the following methods are supported:

```ruby
# expected options -> { uuid: "ABCD-DCCDDC-12394812389-CDC" }
Applocate::API.restrict(options)
# returns a list (Array) of UUIDs with their status from the command.

# expected options -> { uuid: "ABCD-DCCDDC-12394812389-CDC" }
Applocate::API.unrestrict(options)
# returns a list (Array) of UUIDs with their status from the command.


# expected options -> { uuid: "ABCD-DCCDDC-12394812389-CDC", itunes_id: "003274092" }
Applocate::API.install_app(options)
# returns a list (Array) of UUIDs with their status from the command.


# expected options -> { uuid: "ABCD-DCCDDC-12394812389-CDC" }
Applocate::API.app_list(options)
# returns a list (Array) of UUIDs with their apps.

Applocate::API.register_device
# returns :id, :uuid, :enrollment_url
# since the uuid comes from the device it will be nil until the device enrolls

Applocate::API.list_devices
# return an array of devices containing :id, :uuid, :enrollment_url
# once the device has enrolled it will have a :uuid but no :enrollment_url

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/applocate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
