module Cosmos
  class HypermediaError < StandardError; end

  class UnknownLink < HypermediaError
    attr_reader :rel

    def initialize(rel)
      @rel = rel
    end
  end

  class UnknownQuery < UnknownLink; end

  class FailedCheck < HypermediaError
    attr_reader :check_type

    def initialize(check_type)
      @check_type = check_type
    end
  end
end
