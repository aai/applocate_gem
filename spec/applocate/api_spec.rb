require 'spec_helper'

describe Applocate::API do
  describe 'configuration' do
    subject { Applocate::API }
    before(:all) {
      Applocate.configure do |config|
        config.token = 'token'
        config.secret = 'secret'
      end
    }

    it 'uses the configured key' do
      expect(subject.key).to eq('token')
    end
    it 'uses the configured secret' do
      expect(subject.secret).to eq('secret')
    end
    it 'uses the base URI to be set to the default' do
      expect(subject.base_uri).to eq("https://www.applocate.com/api/v1")
    end
  end

  describe '.restrict' do
    it 'pushes restrictions to a list of devices' do
      device_list = { uuid: "ABCD-DCCDDC-12394812389-CDC" }
      results = []

      Applocate::API.should_receive(:post)
        .with('/deploy/profile', body: device_list.to_json)
        .and_return(results)

      Applocate::API.restrict device_list
    end

    describe '.unrestrict' do
      it 'removes the restrictions profile from devices' do
        device_list = { uuid: "ABCD-DCCDDC-12394812389-CDC" }
        results = []

        Applocate::API.should_receive(:delete)
          .with('/deploy/profile', body: device_list.to_json)
          .and_return(results)

        Applocate::API.unrestrict device_list
      end
    end

    describe '.install_app' do
      it 'removes the restrictions profile from devices' do
        options = { uuid: "ABCD-DCCDDC-12394812389-CDC", itunes_id: "00123487" }
        results = []

        Applocate::API.should_receive(:post)
          .with('/deploy/app', body: options.to_json)
          .and_return(results)

        Applocate::API.install_app options
      end
    end

    describe '.app_list' do
      it 'removes the restrictions profile from devices' do
        device_list = { uuid: "ABCD-DCCDDC-12394812389-CDC" }
        results = []

        Applocate::API.should_receive(:post)
          .with('/deploy/app_list', body: device_list.to_json)
          .and_return(results)

        Applocate::API.app_list device_list
      end
    end
  end
end
