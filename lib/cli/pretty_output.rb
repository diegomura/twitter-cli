require 'pastel'

module PrettyString
  refine String do
    # Adds blankspace padding before the string
    #
    # @param lenght number of blankspaces
    #
    # @return [String] padded string
    def lpadding(length)
      " " * length + self
    end
  end
end

class PrettyOutput
  using PrettyString

  @pastel = Pastel.new
  @line_size = 60
  @default_options = { color: "bright_black", lpad_size:4, roffset:0, decorator:"" }

  # Print a list of tweets
  #
  # @param [List] tweets list of tweets to print
  def self.print_tweets(tweets)
    tweets.each do |tweet|
      print_tweet(tweet)
    end
  end

  # Prints a list of trending topics
  #
  # @param [List] tts list of trending topics
  def self.print_trending_topics(trending_topics)
    print_blankline
    trending_topics.each do |tt|
      show("- #{tt.name}")
    end
    print_blankline
  end

  private

  # Prints a user friends and followers
  #
  # @param [User] user user to be printed
  def self.print_user_status(user)
    show("#️⃣  #{user.statuses_count}    "\
      "⏭  #{user.friends_count}    "\
      "⏮  #{user.followers_count}", roffset:2)
  end

  # Print a user
  #
  # @param [User] user user to be printed
  def self.print_user(user)
    print_blankline
    show("@#{user.screen_name}", color:'black', decorator:'bold', lpad_size:2)
    print_trim_data(user.description)
    print_blankline
    print_user_status(user)
    print_blankline
  end

  # Prints a tweet
  #
  # @param [Twitter::Tweet] tweet tweet to be printed
  def self.print_tweet(tweet)
    print_blankline
    show("@#{tweet.user.screen_name}", color:'black', decorator:'bold', lpad_size:2)
    print_trim_data(tweet.text)
    print_blankline
    show("🔁  #{tweet.retweet_count}   ❤️  #{tweet.favorite_count}", roffset:1)
    print_blankline
    show("")
  end

  # Splits a string in many fixed lenght lines, without cutting any word in half
  # and prints it
  #
  # @param [String] data string to print
  def self.print_trim_data(data)
    lines = data.scan(/.{1,50}\b|.{1,50}/)
    lines.each do |line|
      show(line)
    end
  end

  # Prints a given line
  #
  # @param [String] line line to be printed
  # @param [String] color font color (optional)
  # @param [String] decorator font decorator (optional)
  # @param [Integer] lpad_size number of blankspaces before line (optional)
  # @param [Integer] roffset number of additional blankspaces added after the line (optional)
  def self.show(line, opts = {})
    opts = @default_options.merge(opts)
    line = line.lpadding(opts[:lpad_size]).ljust(@line_size + opts[:roffset])
    if @pastel.respond_to?(opts[:decorator])
      puts @pastel.send(opts[:decorator]).send(opts[:color]).on_bright_white(line)
    else
      puts @pastel.send(opts[:color]).on_bright_white(line)
    end
  end

  # Prints a blankline
  def self.print_blankline
    puts @pastel.bright_white.on_bright_white(".".ljust(@line_size))
  end
end
