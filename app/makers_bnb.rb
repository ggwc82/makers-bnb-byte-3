ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

class MakersBnB < Sinatra::Base

  get '/spaces' do
  	@spaces = Space.all
  	erb :homepage
	  end

	get '/spaces/new' do
	  erb :'spaces/new'
	end

	post '/spaces' do
	  Space.create(name: params[:name],
                 location: params[:location],
                 description: params[:description],
                price_per_night: params[:price_per_night])
	  redirect to('/spaces')
	end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
