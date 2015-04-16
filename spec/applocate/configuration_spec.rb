require 'spec_helper'

describe Applocate::Configuration do
  describe 'configure' do
    describe 'with ENV variables' do
      before(:all) do
        ENV["APPLOCATE_TOKEN"] = "APPLOCATE_TOKEN"
        ENV["APPLOCATE_SECRET"] = "APPLOCATE_SECRET"
        ENV["APPLOCATE_BASE_URL"] = "APPLOCATE_BASE_URL"
      end

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.token).to eq('APPLOCATE_TOKEN')
      end

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.secret).to eq('APPLOCATE_SECRET')
      end
    end

    describe 'with a configuration block' do
      subject { Applocate.configuration }
      before(:each) do
        Applocate.configure do |config|
          config.token = 'token'
          config.secret = 'secret'
          config.base_url = 'base_url'
        end
      end

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.token).to eq('token')
      end

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.secret).to eq('secret')
      end

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.base_url).to eq('base_url')
      end
    end

    it 'has a default value for base url' do
      expect(subject.base_url).to eq("https://www.applocate.com")
    end
  end
end
