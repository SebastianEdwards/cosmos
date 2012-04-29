require "middleware"
require "faraday"
require "faraday_middleware"
require "faraday_collection_json"
require "rack-cache"

Dir[File.dirname(__FILE__) + '/middleware/*.rb'].each {|file| require file }

::Middleware::Runner.const_set :EMPTY_MIDDLEWARE, lambda { |env| env }

module Cosmos
  class Service
    attr_accessor :endpoint, :cache

    def initialize(&block)
      yield(self)
    end

    def client
      Faraday.new do |builder|
        builder.request  :url_encoded
        builder.request  :retry
        builder.response :collection_json, :content_type => /^application\/vnd\.collection\+json/
        builder.response :json, :content_type => /^application\/json/
        if @cache
          builder.use FaradayMiddleware::RackCompatible, Rack::Cache::Context,
            @cache.merge({ignore_headers: %w[Set-Cookie X-Content-Digest]})
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
