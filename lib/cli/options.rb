require 'optparse'
require_relative '../twitter_client'
require_relative 'pretty_output'

module Twitter
  class Options

    attr_reader :twitter_client

    def initialize(argv)
      @options = {}
      parse(argv)
    end

    private

    def parse(argv)
      options = OptionParser.new do |opts|
        opts.banner = "Usage: twitter_client [options] word ..."

        opts.on("-c", "--credentials credentials_file", String,
                "Set a credential file") do |credentials_file|
          @options[:credentials] = credentials_file
        end

        opts.on("-r", "--trending place_name", String,
                "Get trending topics") do |place_name|
          @options[:client_method] = "trending_topics"
          @options[:print_methods] = "print_trending_topics"
          @options[:args] = place_name
        end

        opts.on("-t", "--tweets hashtag", String,
                "Hashtag to search for tweets") do |hashtag|
          @options[:client_method] = "search_tweets"
          @options[:print_methods] = "print_tweets"
          @options[:args] = [hashtag, 10]
        end

        opts.on("-u", "--userbio username", String, "Get user's bio") do |name|
          @options[:client_method] = "search_user"
          @options[:print_methods] = "print_user"
          @options[:args] = name
        end

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end
      end

      argv = ["-h"] if argv.empty?
      options.parse!(argv)

      begin
        api_client = APIClient.new(@options[:credentials])
        twitter_client = Client.new(api_client)
        client_method = @options[:client_method]
        if client_method
          response = twitter_client.send(client_method, *@options[:args])
          PrettyOutput.send(@options[:print_methods], response)
        end
      rescue OptionParser::ParseError => e
        STDERR.puts e.message, "\n", opts
        exit(-1)
      end
    end
  end
end
