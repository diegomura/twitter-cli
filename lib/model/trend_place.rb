module Twitter
  class TrendPlace
    attr_reader :woeid, :name, :country, :country_code

    def initialize(trend_place_data)
      @woeid = trend_place_data['woeid']
      @name = trend_place_data["name"]
      @country = trend_place_data["country"]
      @country_code = trend_place_data["country_code"]
    end

    def to_s
      @name
    end
  end
end
