module Cosmos
  class UnknownLinkError < StandardError
    attr_reader :rel

    def initialize(rel)
      @rel = rel
    end
  end

  module Middleware
    class Traverse
      def initialize(app, rel)
        @app = app
        @rel = rel
      end

      def call(env)
        link = env[:current_body].link(@rel)
        raise UnknownLinkError.new(@rel) if link.nil?
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
