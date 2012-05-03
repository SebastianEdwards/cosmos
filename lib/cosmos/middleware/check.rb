module Cosmos
  module Middleware
    class Check
      def initialize(app, type, error = FailedCheck)
        @app    = app
        @type   = type
        @error =  error
      end

      def has_one_item?
        has_items? && @subject.items.length == 1
      end

      def has_items?
        @subject.respond_to? :items
      end

      def call(env)
        @subject = env[:current].body
        if respond_to? @type
          success = send(@type)
          raise @error.new(@type) unless success
        end
        @app.call env
      end
    end
  end
end
