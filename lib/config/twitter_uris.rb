module Twitter
  module URI
    API_BASE_URI         = "https://api.twitter.com/"
    API_VERSION          = "1.1"
    API_URI              = API_BASE_URI + API_VERSION
    TRENDS_PLACE_URI     = API_URI + "/trends/place.json"
    TRENDS_AVAILABLE_URI = API_URI + "/trends/available.json"
    SEARCH_TWEETS_URI    = API_URI + "/search/tweets.json"
    USER_SHOW_URI        = API_URI + "/users/show.json"
  end
end
