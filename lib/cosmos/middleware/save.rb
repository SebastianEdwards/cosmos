module Cosmos
  module Middleware
    class Save
      def initialize(app, key)
        @app = app
        @key = key
      end

      def call(env)
        env[@key] = env[:current]
        @app.call env
      end
    end
  end
end
