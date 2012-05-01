require "cosmos/version"

module Cosmos
  module MiddlewareRegistry
    def register_middleware(mapping)
      (@registered_middleware ||= {}).update(mapping)
    end

    def lookup_middleware(key)
      unless defined? @registered_middleware and found = @registered_middleware[key]
        raise "#{key.inspect} is not registered on #{self}"
      end
      found = @registered_middleware[key] = found.call if found.is_a? Proc
      found.is_a?(Module) ? found : const_get(found)
    end
  end

  autoload :Adaptor,          "cosmos/adaptor"
  autoload :Middleware,       "cosmos/middleware"
  autoload :RackMiddleware,   "cosmos/rack_middleware"
  autoload :ServiceClient,    "cosmos/service_client"
end
