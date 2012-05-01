require "middleware"
require "faraday"
require "faraday_middleware"
require "faraday_collection_json"
require "rack-cache"

::Middleware::Runner.const_set :EMPTY_MIDDLEWARE, lambda { |env| env }

module Cosmos
  class ServiceClient
    attr_writer :cache, :default_endpoint, :http_client

    def initialize(opts = {})
      opts.each do |k,v|
        send("#{k}=", v) if respond_to?("#{k}=")
      end
    end

    def call(env = {}, &block)
      env = default_env.merge(env)
      stack = ::Middleware::Builder.new
      pretty_builder = Middleware::PrettyBuilder.new(stack)
      block.call(pretty_builder) if block_given?
      stack.call(env)
    end

    private
    def default_env
      {
        client:           http_client,
        default_endpoint: @default_endpoint
      }
    end

    def http_client
      @http_client ||= Faraday.new do |builder|
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
  end
end
