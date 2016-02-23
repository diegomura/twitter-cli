module Twitter
  class TrendTopic
    attr_reader :name, :url

    def initialize(trend_topic_data)
      @name = trend_topic_data['name']
      @url = trend_topic_data["url"]
    end

    def to_s
      @name
    end
  end
end
