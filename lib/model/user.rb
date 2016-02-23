require 'date'

module Twitter
  class User
    attr_reader :id, :name, :screen_name, :description, :followers_count,
                :friends_count, :statuses_count, :profile_image_url, :created_at

    def initialize(user_data)
      @id = user_data["id"]
      @name = user_data["name"]
      @screen_name = user_data["screen_name"]
      @description = user_data["description"]
      @followers_count = user_data["followers_count"]
      @friends_count = user_data["friends_count"]
      @statuses_count = user_data["statuses_count"]
      @profile_image_url = user_data["profile_image_url"]
      @created_at = Date.parse(user_data["created_at"])
    end

    def to_s
      @screen_name
    end
  end
end
