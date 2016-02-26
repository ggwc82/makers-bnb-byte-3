class Space
  include DataMapper::Resource


  has n, :users, through: Resource

  property :id,     Serial
  property :name,  String
  property :location, String
  property :description, String
  property :price_per_night, Integer
  property :available_from, Date
  property :available_to, Date

  validates_presence_of :name, :location, :description, :price_per_night, :available_from, :available_to

  
end


