require 'webmock/rspec'
require_relative 'support/fake_twitter_client'
require_relative '../lib/config/twitter_uris'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |c|
  c.before(:each, :api => :external) do
    stub_request(:any, /api.twitter.com/).to_rack(FakeTwitterClient)
  end
end
