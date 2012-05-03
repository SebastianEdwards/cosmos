module Cosmos
  class CollectionJSON::Query
    def initialize(app, rel, key = :data)
      @app = app
      @rel = rel
      @key = key
    end

    def call(env)
      data = env[@key]

      query = env[:current].body.query(@rel)
      raise UnknownQuery.new(@rel) if query.nil?
      uri = query.build(data)

      response = env[:client].get(uri, nil, env[:headers])
      env[:current] = response

      @app.call env
    end
  end
end
