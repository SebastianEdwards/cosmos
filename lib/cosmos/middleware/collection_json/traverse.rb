module Cosmos
  class CollectionJSON::Traverse
    def initialize(app, rel)
      @app = app
      @rel = rel
    end

    def call(env)
      link = env[:current].body.link(@rel)
      raise UnknownLink.new(@rel) if link.nil?
      response = env[:client].get(link.href, nil, env[:headers])
      env[:current] = response
      @app.call env
    end
  end
end
