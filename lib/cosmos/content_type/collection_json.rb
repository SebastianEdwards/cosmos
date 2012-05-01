require "cosmos/content_type"

module Cosmos
  class CollectionJSON < ContentType
    associate_media_type  "application/vnd.collection+json"
    dependency            "collection-json"

    autoload :Traverse,   "cosmos/middleware/collection_json/traverse"
    register_middleware \
      :traverse       => :Traverse
  end
end
