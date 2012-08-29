require 'spec_helper'

describe Restforce::Middleware::Authentication do
  include_context 'basic client'

  let(:oauth_token) { '00Dx0000000BV7z!AR8AQAxo9UfVkh8AlV0Gomt9Czx9LjHnSSpwBMmbRcgKFmxOtvxjTrKW19ye6PE3Ds1eQz3z8jr3W7_VbWmEu4Q8TVGSTHxs' }

  describe 'authentication' do
    before do
      @requests = [].tap do |requests|
        requests << stub_request(:get, %r{/services/data/v24\.0/sobjects}).
          with(:headers => {'Authorization' => 'OAuth'}).
          to_return(:status => 401, :body => fixture(:expired_session_response))

        requests << stub_request(:get, 'https://login.salesforce.com/services/oauth2/authorize?client_id=client_id' \
                     '&client_secret=client_secret&grant_type=password&password=bar&username=foo').
         to_return(:status => 200, :body => fixture(:auth_success_response))

        requests << stub_request(:get, %r{/services/data/v24\.0/sobjects}).
          with(:headers => {'Authorization' => "OAuth #{oauth_token}"}).
          to_return(:status => 401, :body => fixture(:expired_session_response))
      end

      client.get '/services/data/v24.0/sobjects'
    end

    after do
      @requests.each do |request|
        request.should have_been_requested.once
      end
    end

    context 'when a username and password is set' do
      let(:client_options) { {:username => 'foo', :password => 'bar', :client_id => 'client_id', :client_secret => 'client_secret'} }

      describe 'the client options' do
        subject { client.instance_variable_get :@options }

        its([:instance_url]) { should eq 'https://na1.salesforce.com' }
        its([:oauth_token]) { should eq oauth_token }
      end
    end
  end
end
