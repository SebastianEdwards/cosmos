module Cosmos
  module Middleware
    extend MiddlewareRegistry

    autoload :Check,      "cosmos/middleware/check"
    autoload :Discover,   "cosmos/middleware/discover"
    autoload :Load,       "cosmos/middleware/load"
    autoload :Save,       "cosmos/middleware/save"
    autoload :SetHeaders, "cosmos/middleware/set_headers"
    autoload :Stub,       "cosmos/middleware/stub"
    autoload :Submit,     "cosmos/middleware/submit"
    autoload :Traverse,   "cosmos/middleware/traverse"

    register_middleware \
      :check        => :Check,
      :discover     => :Discover,
      :enter        => :Discover,
      :load         => :Load,
      :save         => :Save,
      :set_header   => :SetHeaders,
      :set_headers  => :SetHeaders,
      :submit       => :Submit,
      :traverse     => :Traverse

    class PrettyBuilder
      def initialize(stack)
        @stack = stack
      end

      def method_missing(method_sym, *args, &block)
        middleware = Middleware.lookup_middleware(method_sym)
        @stack.use middleware, *args, &block
      end
    end
  end
end
