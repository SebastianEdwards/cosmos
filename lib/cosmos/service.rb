require "faraday"
require "faraday_middleware"
require "faraday_collection_json"
require "rack-cache"

module Cosmos
  class Service
    attr_writer :endpoint

    def initialize(&block)
      yield(self)
    end

    def client
      @client ||= Faraday.new do |builder|
        builder.request  :url_encoded
        builder.request  :retry
        builder.response :collection_json, :content_type => /collection\+json$/
        builder.response :json, :content_type => /application\/json$/
        if false
          builder.use FaradayMiddleware::RackCompatible, Rack::Cache::Context,
            :default_ttl => 0,
            :metastore   => "file:#{@cache_dir}/rack/meta",
            :entitystore => "file:#{@cache_dir}/rack/body",
            :ignore_headers => %w[Set-Cookie X-Content-Digest]
        end
        builder.adapter  :typhoeus
      end
    end

    def endpoint
      client.get(@endpoint).body
    end
  end
end
