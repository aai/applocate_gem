require "httparty"

module Applocate
  class API
    include HTTParty
    base_uri Applocate.configuration.base_url
    headers 'Content-Type' => "application/json"
    format :plain

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC" }
    def self.restrict(options)
      response = self.post('/deploy/profile', body: options.to_json)
      JSON.parse response.body rescue []
    end

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC" }
    def self.unrestrict(options)
      response = self.delete('/deploy/profile', body: options.to_json)
      JSON.parse response.body rescue []
    end

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC", itunes_id: "003274092" }
    def self.install_app(options)
      response = self.post('/deploy/app', body: options.to_json)
      JSON.parse response.body rescue []
    end

    # expected options { uuid: "ABCD-DCCDDC-12394812389-CDC" }
    def self.app_list(options)
      response = self.post('/deploy/app_list', body: options.to_json)
      JSON.parse response.body rescue []
    end

    def self.key
      Applocate.configuration.token
    end

    def self.secret
      Applocate.configuration.secret
    end
  end
end
