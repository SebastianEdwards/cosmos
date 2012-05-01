module Cosmos
  class RackMiddleware
    def initialize(app, opts = {})
      @app  = app
      @service_client = ServiceClient.new(opts)
    end

    def call(env)
      env['cosmos'] = @service_client
      @app.call env
    end
  end
end
