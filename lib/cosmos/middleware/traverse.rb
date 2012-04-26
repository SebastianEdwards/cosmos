module Cosmos
  module Middleware
    class Traverse
      def initialize(app, rel)
        @app = app
        @rel = rel
      end

      def call(env)
        link = env[:current_body].link(@rel)
        client = env[:client]
        response = env[:client].get(link.href)
        env[:current_status] = response.status
        env[:current_body] = response.body
        env[:current_headers] = response.headers
        @app.call env
      end
    end
  end
end
