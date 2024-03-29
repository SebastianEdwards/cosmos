module Cosmos
  module Middleware
    class Load
      def initialize(app, key)
        @app = app
        @key = key
      end

      def call(env)
        env[:current] = env[@key]
        @app.call env
      end
    end
  end
end
