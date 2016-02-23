require 'data_mapper'
require 'dm-postgres-adapter'

class Space

  include DataMapper::Resource

  property :id,     Serial
  property :name,  String
  property :location, String
  property :description, String

end

DataMapper.setup(:default, "postgres://localhost/makersbnb_byte3_test")
DataMapper.finalize
DataMapper.auto_upgrade!
