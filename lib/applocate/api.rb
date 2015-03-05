require "httparty"

module Applocate
  class API
    include HTTParty
    base_uri Applocate.configuration.base_url
    headers 'Content-Type' => "application/json"
    format :plain

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC" }
    def self.restrict(options = {})
      response = self.post('/deploy/profile', { body: options.to_json, headers: authentication })
      JSON.parse response.body rescue []
    end

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC" }
    def self.unrestrict(options = {})
      response = self.delete('/deploy/profile', { body: options.to_json, headers: authentication })
      JSON.parse response.body rescue []
    end

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC", itunes_id: "284910350" }
    def self.install_app(options = {})
      response = self.post('/deploy/app', { body: options.to_json, headers: authentication })
      JSON.parse response.body rescue []
    end

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC" }
    def self.app_list(options = {})
      response = self.post('/deploy/app_list', { body: options.to_json, headers: authentication })
      JSON.parse response.body rescue []
    end

    # expected options { name: "Steve J's iPad Air", identifier: "XXX-123456 APPLE INC." }
    def self.register_device(options = {})
      options = { name: name, identifier: identifier }
      response = self.post('/api/devices', { body: options.to_json, headers: authentication })
      JSON.parse response.body rescue []
    end

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC" }
    def self.list_devices
      response = self.get('/api/devices', { headers: authentication })
      JSON.parse response.body rescue []
    end

    def self.authentication
      { "X-Applocate-Secret" => secret, "X-Applocate-Token" => token, 'Content-Type' => "application/json" }
    end

    def self.token
      Applocate.configuration.token
    end

    def self.secret
      Applocate.configuration.secret
    end
  end
end
