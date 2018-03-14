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
# expected options -> { udid: "ABCD-DCCDDC-12394812389-CDC", restrictions: {"allowSafari" => false} }
# optional options -> { expires_at: "2000-01-01T00:00:00Z", expires_in: 1337, profile_name: "com.example.my.profile"}
Applocate::API.restrict(options)
# returns a list (Array) of UUIDs with their status from the command.

# expected options -> { udid: "ABCD-DCCDDC-12394812389-CDC" }
Applocate::API.unrestrict(options)
# returns a list (Array) of UUIDs with their status from the command.

# expected options { udid: "ABCD-DCCDDC-12394812389-CDC", vpn_username: "123456", vpn_password: "p@ssw0rd" }
Applocate::API.self.install_vpn(options)
# returns a list (Array) of UUIDs with their status from the command.

# expected options { udid: "ABCD-DCCDDC-12394812389-CDC" }
Applocate::API.self.remove_vpn(options)
# returns a list (Array) of UUIDs with their status from the command.

# expected options -> { udid: "ABCD-DCCDDC-12394812389-CDC", itunes_id: "003274092" }
Applocate::API.install_app(options)
# returns a list (Array) of UUIDs with their status from the command.

# expected options -> { udid: "ABCD-DCCDDC-12394812389-CDC" }
Applocate::API.app_list(options)
# returns a list (Array) of UUIDs with their apps.

# expected options -> { udid: "ABCD-DCCDDC-12394812389-CDC" }
Applocate::API.mdm_app_list(options)
# returns a list (Array) of UUIDs with apps that are being managed by MDM.

# expected options -> { name: "the name your call the device (255 chars)", identifier: "INTERNAL_CORP_ID_UPTO_255CHAR" }
# NOTE: you can also add an optional configuration: "default" and it will apply a named configuration that matches.
Applocate::API.register_device(options)
# returns :id, :udid, :enrollment_url
# since the udid comes from the device it will be nil until the device enrolls

Applocate::API.list_devices
# return an array of devices containing :id, :udid, :enrollment_url
# once the device has enrolled it will have a :udid but no :enrollment_url

# expected options -> { udid: "ABCD-DCCDDC-12394812389-CDC" }
#     OR           -> { id: 1234567 }
Applocate::API.delete_device(options)
# delete a device with a given id

# expected params, udid = "ABCD-DCCDDC-12394812389-CDC"
Applocate::API.profile_list(udid)
# returns a list (Array) of install profiles. **excluding any provisioning profiles.**

# expected params, udid = "ABCD-DCCDDC-12394812389-CDC"
Applocate::API.recent_checkins(udid)
# returns a list of the checkins for the device for the last two days.

# expected params, udid = "ABCD-DCCDDC-12394812389-CDC"
Applocate::API.recent_commands(udid)
# returns a list of commands issued to the device is the last two days.

# expected params, udid = "ABCD-DCCDDC-12394812389-CDC", commmand_uuid = "xxxx-xxx-xxxx-xxxxxxxxxxx"
Applocate::API.cancel_commmand(udid, command_uuid)
# returns the cancelled command.

# expected params, udid = "ABCD-DCCDDC-12394812389-CDC"
Applocate::API.active_commands(udid)
# returns a list of the active commands for a device.

# expected params, udid = "ABCD-DCCDDC-12394812389-CDC"
Applocate::API.restrictions(udid)
# returns a list of the restrictions for a device.

# expected params: udid = "ABCD-DCCDDC-12394812389-CDC", name = "me.example.restrictions", options = {}
# required options -> { restrictions: {"allowSafari" => false} }
# optional options -> { expires_at: "2000-01-01T00:00:00Z", expires_in: 1337 }
Applocate::API.apply_named_restrictions(udid, name, options)
# returns the udid and the status of the command as JSON

# expected params, udid = "ABCD-DCCDDC-12394812389-CDC", name = "me.example.restrictions"
Applocate::API.remove_named_restrictions(udid, name)
# returns the udid and the status of the command as JSON

```

If you need to change which server you are connecting to, Applocate provides
access to its internal config options for the secret and the token. For the URL
it provides the same options as a standard HTTParty connection:

```ruby
  Applocate.configuration.token = "xxx-xxxxxxx"
  Applocate.configuration.secret = "shhh... secret"
  Applocate.base_uri "https://www.applocate.com"
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/applocate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
