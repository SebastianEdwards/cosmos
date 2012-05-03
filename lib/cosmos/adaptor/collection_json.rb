require "cosmos"

module Cosmos
  class CollectionJSON < Adaptor
    associate_media_type  "application/vnd.collection+json"
    dependency            "collection-json"

    autoload :Query,      "cosmos/middleware/collection_json/query"
    autoload :Submit,     "cosmos/middleware/collection_json/submit"
    autoload :Traverse,   "cosmos/middleware/collection_json/traverse"
    register_middleware \
      :query          => :Query,
      :submit         => :Submit,
      :traverse       => :Traverse
  end
end
