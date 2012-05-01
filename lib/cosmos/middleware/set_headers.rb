module Cosmos
  module Middleware
    class SetHeaders
      def initialize(app, headers)
        @app = app
        @headers = headers
      end

      def call(env)
        env[:headers].merge!(@header)
        @app.call env
      end
    end
  end
end
