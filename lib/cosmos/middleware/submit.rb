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

        response = env[:client].post do |req|
          req.url env[:current_body].href
          req.headers['Content-Type'] = 'application/vnd.collection+json'
          req.body = built_template.to_json
        end

        env[:current_status] = response.status
        env[:current_body] = response.body
        env[:current_headers] = response.headers
        @app.call env
      end
    end
  end
end
