module Cosmos
  module Middleware
    class Submit
      def initialize(app, key = :data)
        @app = app
        @key = key
      end

      def call(env)
        data = env[@key]
        template = env[:current_body].template
        built_template = template.build(data)
        raise built_template.inspect.to_json

        response = env[:client].post(link.href)
        env[:current_status] = response.status
        env[:current_body] = response.body
        env[:current_headers] = response.headers
        @app.call env
      end
    end
  end
end
