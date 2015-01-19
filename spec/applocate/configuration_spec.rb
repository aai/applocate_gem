require 'spec_helper'

describe Applocate::Configuration do
  describe 'configure' do
    describe 'with ENV variables' do
      before(:all) {
        ENV["APPLOCATE_TOKEN"] = "APPLOCATE_TOKEN"
        ENV["APPLOCATE_SECRET"] = "APPLOCATE_SECRET"
        ENV["BASE_URL"] = "BASE_URL"
      }

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.token).to eq('APPLOCATE_TOKEN')
      end

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.secret).to eq('APPLOCATE_SECRET')
      end

      it 'adds a friend as a participant to the current conversation' do
        expect(subject.base_url).to eq('BASE_URL')
      end
    end

    describe 'with a configuration block' do
      subject { Applocate.configuration }
      before(:each) {
        Applocate.configure do |config|
          config.token = 'token'
          config.secret = 'secret'
          config.base_url = 'base_url'
        end
      }

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
      expect(subject.base_url).to eq("https://www.applocate.com/api/v1")
    end
  end
end
