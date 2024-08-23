# Problem: URL Shortener
# You need to build a simple URL shortener service. The service should be able to:

# Accept a long URL and return a shortened version of it.
# Redirect a shortened URL to the original long URL when visited.

# Requirements:
# Create: A method that takes a long URL and returns a shortened URL.
# Redirect: A method that takes a shortened URL and returns the original long URL.
# Validation: Ensure that the long URL is a valid URL.
# Unique Shortened URLs: Ensure that each unique long URL has its unique shortened version. Two identical long URLs should return the same shortened URL.
# Database: Use an in-memory store (e.g., a hash) to store mappings between the long URLs and the shortened URLs.
require 'base64'
require 'uri'

module UrlService
    URL_STORE = {}

    def self.store_url(url)
      stored_url = URL_STORE.values.include?(url)
      return if stored_url.nil?
      # check for collision 
      url_hash = url.hash.to_s
      unique_hash = URL_STORE.keys.include?(url_hash)
      if unique_hash == true
        url_hash = Base64.encode64(url).to_s
      end
      URL_STORE[url_hash] = url
      url_hash
    end

    def self.retrieve_long_url(short_url)
      long_url = URL_STORE[short_url]
      puts long_url
    end

    def self.short_url(url)
      if !valid_url?(url)
        puts "Invalid URL"
        return
      end
      url_hash = store_url(url)
      uri_host = URI.parse(url).host

      short_url = uri_host+'/'+url_hash
      puts short_url
    end

    def self.valid_url?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) && !uri.host.nil?
    rescue URI::InvalidURIError
        false
    end 

end
