module Cosmos
  class UnknownLinkError < StandardError
    attr_reader :rel

    def initialize(rel)
      @rel = rel
    end
  end

  module Middleware
    class Traverse < AdaptorMiddlewareProxy
      middleware_type :traverse
    end
  end
end
