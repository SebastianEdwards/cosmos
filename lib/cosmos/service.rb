require "middleware"
require "faraday"
require "faraday_middleware"
require "faraday_collection_json"
require "rack-cache"

Dir[File.dirname(__FILE__) + '/middleware/*.rb'].each {|file| require file }

module Cosmos
  class Service
    attr_accessor :endpoint, :cache_dir

    def initialize(&block)
      yield(self)
    end

    def client
      Faraday.new do |builder|
        builder.request  :url_encoded
        builder.request  :retry
        builder.response :collection_json, :content_type => /collection\+json($|;(((\s+|)\w+=\w+)*)$)/
        builder.response :json, :content_type => /^application\/json/
        if @cache_dir
          builder.use FaradayMiddleware::RackCompatible, Rack::Cache::Context,
            :default_ttl => 0,
            :metastore   => "file:#{@cache_dir}/rack/meta",
            :entitystore => "file:#{@cache_dir}/rack/body",
            :ignore_headers => %w[Set-Cookie X-Content-Digest]
        end
        builder.adapter  :typhoeus
      end
    end

    def default_env
      {
        client: client,
        service: self
      }
    end

    def call(env = {}, &block)
      env = default_env.merge(env)
      ::Middleware::Builder.new(&block).call env
    end
  end
end
