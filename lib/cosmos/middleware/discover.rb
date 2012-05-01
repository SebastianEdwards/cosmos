module Cosmos
  class InvalidEndpointError < StandardError; end

  module Middleware
    class Discover
      def initialize(app, endpoint = nil)
        @app = app
        @endpoint = endpoint
      end

      def call(env)
        endpoint = @endpoint || env[:default_endpoint] or raise(InvalidEndpointError.new)
        response = env[:client].get(endpoint, nil, env[:headers])
        env[:current] = response
        @app.call env
      end
    end
  end
end
