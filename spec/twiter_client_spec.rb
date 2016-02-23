require 'spec_helper'

require 'twitter_client'
require_relative 'support/file_handler'

describe Twitter::Client do
  include FileHandler

  let(:api_client) { APIClient.new }
  let(:twitter_client) { Twitter::Client.new api_client }

  describe ".trending_topics", :api => :external do
    specify "returns non-empty array of trending topic for existing location" do
      tts = twitter_client.trending_topics("Seoul")
      expect(tts).to_not be_empty
    end

    specify "returns empty array for non-existing location" do
      tts = twitter_client.trending_topics("Non-worldwide")
      expect(tts).to be_empty
    end
  end

  describe ".search_user", :api => :external do
    specify "returns user's bio for existing user" do
      tts = twitter_client.search_user("rails")
      expect(tts).to be_an_instance_of(Twitter::User)
    end

    specify "raise Exception for non-existing user" do
      expect{twitter_client.search_user("thisUserDoesNotExists")}
        .to raise_error(Twitter::APIError)
    end
  end

  describe ".trend_places", :api => :external do
    specify "returns trending places list" do
      tts = twitter_client.trend_places
      expect(tts).to_not be_empty
    end

    specify "returns list with TrendPlace objects" do
      tts = twitter_client.trend_places
      tts.each do |trend_place|
        expect(trend_place).to be_an_instance_of(Twitter::TrendPlace)
      end
    end
  end

  describe ".search_tweets", :api => :external do
    specify "returns Tweet array for valid hashtag" do
      tts = twitter_client.search_tweets("#rails", 10)
      expect(tts).to_not be_empty
    end

    specify "returns array of lenght 1 (of 2 existent)" do
      tts = twitter_client.search_tweets("#rails", 1)
      expect(tts.size).to eq(1)
    end

    specify "returns empty array for invalid hashtag" do
      tts = twitter_client.search_tweets("#notexist", 10)
      expect(tts).to be_empty
    end
  end

  describe ".parse" do
    context "tweets" do
      let(:tweets_data) { JSON.parse(read_fixture("#rails_tweets.json"))["statuses"] }

      specify "returns one Tweet object per input object" do
        input_size = tweets_data.size
        parsed_data = twitter_client.parse(tweets_data, Twitter::Tweet)
        expect(parsed_data.size).to eq(input_size)
      end

      specify "returns array of Tweet objects for valid input" do
        result = twitter_client.parse(tweets_data, Twitter::Tweet)
        result.each do |tweet|
          expect(tweet).to be_an_instance_of(Twitter::Tweet)
        end
      end

      specify "returns empty array when empty array is passed" do
        expect(twitter_client.parse([], Twitter::Tweet)).to be_empty
      end
    end

    context "trend_places" do
      let(:trend_places_data) { JSON.parse(read_fixture("trend_places.json")) }

      specify "returns one TrendPlace object per input object" do
        input_size = trend_places_data.size
        parsed_data = twitter_client.parse(trend_places_data, Twitter::TrendPlace)
        expect(parsed_data.size).to eq(input_size)
      end

      specify "returns array of TrendPlace objects for valid input" do
        result = twitter_client.parse(trend_places_data, Twitter::TrendPlace)
        result.each do |trend_place|
          expect(trend_place).to be_an_instance_of(Twitter::TrendPlace)
        end
      end

      specify "returns empty array when empty array is passed" do
        expect(twitter_client.parse([], Twitter::TrendPlace)).to be_empty
      end
    end

    context "trend_topics" do
      let(:trend_topics_data) { JSON.parse(read_fixture("trend_topics.json")) }

      specify "returns one TrendTopic object per input object" do
        input_size = trend_topics_data.size
        parsed_data = twitter_client.parse(trend_topics_data, Twitter::TrendTopic)
        expect(parsed_data.size).to eq(input_size)
      end

      specify "returns array of TrendTopic objects for valid input" do
        result = twitter_client.parse(trend_topics_data, Twitter::TrendTopic)
        result.each do |trend_topic|
          expect(trend_topic).to be_an_instance_of(Twitter::TrendTopic)
        end
      end

      specify "returns empty array when empty array is passed" do
        expect(twitter_client.parse([], Twitter::TrendTopic)).to be_empty
      end
    end
  end
end
