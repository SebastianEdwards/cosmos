module Cosmos
  module Middleware
    class Query < AdaptorMiddlewareProxy
      middleware_type :query
    end
  end
end
