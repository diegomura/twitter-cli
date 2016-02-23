require_relative 'api_client'
require_relative 'model/user'
require_relative 'model/tweet'
require_relative 'model/trend_place'
require_relative 'model/trend_topic'
require_relative 'config/twitter_uris'

module Twitter
  class Client

    def initialize(api_client)
      @api_client = api_client
    end

    # Search tweets by a given hashtag
    #
    # @param [String] hashtag query of the search
    # @param [Integer] limit amount of tweets to return
    #
    # @return [Array] list of tweets that have the hashtag passed
    def search_tweets(hashtag, limit=nil)
      response = @api_client.get(URI::SEARCH_TWEETS_URI, { q: hashtag })
      parse(response["statuses"], Tweet, limit)
    end

    # Gets a user's by its username
    #
    # @param [String] username
    #
    # @return [User] user's bio
    def search_user(username)
      response = @api_client.get(URI::USER_SHOW_URI, { screen_name: username })
      User.new(response)
    end

    # Returns the trending topics of a specific location
    #
    # @param [String] place_name location name of the trending topics to get
    #
    # @return [Array] trending topics list of the given location
    def trending_topics(place_name)
      trend_place = trend_place place_name
      return [] unless trend_place
      response = @api_client.get(URI::TRENDS_PLACE_URI, { id: trend_place.woeid })
      parse(response.first["trends"], TrendTopic)
    end

    # Gets a trending place by its name
    #
    # @param [String] name place name
    #
    # @return [TrendPlace] TrendPlace object that represents the trending place, nil otherwise
    def trend_place(name)
      result = trend_places.select { |place| place.name == name }
      result.first
    end

    # Gets the list of available trending places
    #
    # @return [Array] list of available trending places
    def trend_places
      unless @trend_places
        response = @api_client.get(URI::TRENDS_AVAILABLE_URI)
        @trend_places = parse(response, TrendPlace)
      end
      @trend_places
    end

    def parse (response, klass, limit = nil)
      response = response.take(limit) if limit
      response.map { |item_data| klass.new(item_data) }
    end
  end
end
