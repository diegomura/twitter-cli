require 'date'
require_relative 'user'

module Twitter
  class Tweet
    attr_reader :id, :text, :source, :user_name, :retweet_count, :favorite_count,
                :created_at, :user

    def initialize(tweet_data)
      @id = tweet_data["id"]
      @text = tweet_data["text"]
      @source = tweet_data["source"]
      @user = User.new(tweet_data["user"])
      @retweet_count = tweet_data["retweet_count"]
      @favorite_count = tweet_data["favorite_count"]
      @created_at = Date.parse(tweet_data["created_at"])
    end

    def to_s
      @text
    end
  end
end
