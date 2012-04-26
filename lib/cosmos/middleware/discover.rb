module Cosmos
  module Middleware
    class Discover
      def initialize(app)
        @app = app
      end

      def call(env)
        endpoint = env[:service].endpoint
        response = env[:client].get(endpoint)
        env[:current_status] = response.status
        env[:current_headers] = response.headers
        env[:current_body] = response.body
        @app.call env
      end
    end
  end
end
