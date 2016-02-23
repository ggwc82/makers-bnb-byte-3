require 'sinatra/base'
require_relative 'models/space'

class MakersBnB < Sinatra::Base

  get '/spaces' do
  	@spaces = Space.all
  	erb :homepage
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
