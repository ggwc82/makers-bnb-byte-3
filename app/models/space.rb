class Space

  include DataMapper::Resource

  property :id,     Serial
  property :name,  String
  property :location, String
  property :description, String
  property :price_per_night, Integer

end


