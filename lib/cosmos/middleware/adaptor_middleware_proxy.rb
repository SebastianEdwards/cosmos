module Cosmos
  module Middleware
    class AdaptorMiddlewareProxy
      def self.middleware_type(value = nil)
        @middleware_type = value unless value.nil?
        @middleware_type
      end

      def initialize(app, *args, &block)
        @app = app
        @args = args
        @block = block
      end

      def call(env)
        content_type = env[:current].headers['Content-Type']
        if klass = Adaptor.find_by_content_type(content_type)
          if middleware = klass.lookup_middleware(self.class.middleware_type)
            middleware.new(@app, *@args, &@block).call(env)
          else
            raise 'This method is not supported on the current content type.'
          end
        else
          raise 'This content type is not supported.'
        end
      end
    end
  end
end
