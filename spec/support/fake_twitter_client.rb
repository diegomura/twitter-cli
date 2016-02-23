require 'json'
require 'sinatra/base'
require_relative '../../lib/config/twitter_uris'
require_relative 'file_handler'

class FakeTwitterClient < Sinatra::Base
  include FileHandler

  get '/1.1/trends/available.json' do
    json_response 200, 'trend_places.json'
  end

  get '/1.1/trends/place.json' do
    json_response 200, 'trend_topics.json'
  end

  get '/1.1/search/tweets.json' do
    hashtag = params['q'].downcase
    file_exist_or_404("#{hashtag}_tweets.json")
  end

  get '/1.1/users/show.json?' do
    username = params['screen_name'].downcase
    file_exist_or_404("#{username}_user.json")
  end

  private

  def file_exist_or_404(file_name)
    if fixture_exist?(file_name)
      json_response 200, file_name
    else
      status 404
    end
  end

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    read_fixture(file_name)
  end
end
