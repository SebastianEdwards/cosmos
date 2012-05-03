module Cosmos
  class CollectionJSON::Submit
    def initialize(app, key = :data)
      @app = app
      @key = key
    end

    def call(env)
      data = env[@key]
      template = env[:current].body.template
      built_template = template.build(data)

      response = env[:client].post do |req|
        req.url env[:current].body.href
        req.headers['Content-Type'] = 'application/vnd.collection+json'
        req.body = built_template.to_json
      end

      env[:current] = response

      @app.call env
    end
  end
end
