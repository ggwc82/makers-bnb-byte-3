require 'data_mapper'
require 'dm-postgres-adapter'
require_relative './models/space'

DataMapper.setup(:default, "postgres://localhost/makersbnb_byte3_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!