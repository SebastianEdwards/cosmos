module Cosmos
  module Middleware
    class SetHeader
      def initialize(app, header)
        @app = app
        @header = header
      end

      def call(env)
        env[:client].tap do |client|
          client.headers.merge!(@header)
        end
        @app.call env
      end
    end
  end
end
