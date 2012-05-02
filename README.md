# Cosmos

A middleware based hypermedia client.

```ruby
require 'cosmos'
require 'cosmos/adaptor/collection_json'

SERVICE = Cosmos::ServiceClient.new
  default_endpoint: 'http://lolcat-service.com'

output = SERVICE.call do |cosmos|
  cosmos.discover
  cosmos.traverse 'images'
  cosmos.query search: => 'funny'
  cosmos.save :funny_lolcats
end

output[:funny_lolcats].status   # => 200
output[:funny_lolcats].body     # => <CollectionJSON::Collection>
```
