require "cosmos"

module Cosmos
  class CollectionJSON < Adaptor
    associate_media_type  "application/vnd.collection+json"
    dependency            "collection-json"

    autoload :Submit,     "cosmos/middleware/collection_json/submit"
    autoload :Traverse,   "cosmos/middleware/collection_json/traverse"
    register_middleware \
      :submit         => :Submit,
      :traverse       => :Traverse
  end
end
