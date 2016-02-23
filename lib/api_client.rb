require 'oauth'
require 'json'
require 'yaml'
require_relative 'exceptions/twitter_error'
require_relative 'config/twitter_uris'

class APIClient

  DEFAULT_CREDENTIALS = "./default_credentials.yml"

  def initialize(credentials_dir = nil)
    credentials_dir ||= DEFAULT_CREDENTIALS
    @credentials = YAML.load_file credentials_dir
  end

  # Makes a GET request to the given URI
  #
  # @param [String] uri target of the request
  # @param [Hash] params request parameters
  #
  # @return [Array, Hash] response body parsed as JSON
  def get(uri, query = {})
    uri += "?" + URI.encode_www_form(query)
    response = access_token.get(uri)
    handle_response(response)
  end

  private

  # Get OAuth access token
  #
  # @return [AccessToken] access token
  def access_token
    @access_token ||= prepare_access_token
  end

  # Creates the connection with the API and sets the access token
  def prepare_access_token
    consumer = OAuth::Consumer.new(@credentials["consumer_key"],
                                   @credentials["consumer_secret"],
                                   { :site => Twitter::URI::API_BASE_URI,
                                     :scheme => :header })
    token_hash = { :oauth_token => @credentials["access_token"],
                   :oauth_token_secret => @credentials["access_token_secret"] }
    @access_token = OAuth::AccessToken.from_hash(consumer, token_hash)
  end

  # Handles a HTTP response
  #
  # @param [HTTPResponse] response response of the API
  #
  # @return [Hash, Array] response body parsed as JSON
  #
  # @raise [TwitterError] if HTTP wasn't successful
  def handle_response(response)
    case response
    when Net::HTTPSuccess
      JSON.parse(response.body)
    when Net::HTTPNotFound
      raise Twitter::APIError, "Resource not found"
    else
      raise Twitter::APIError, "Unknown error"
    end
  end
end
