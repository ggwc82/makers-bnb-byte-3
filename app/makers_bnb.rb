ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class MakersBnB < Sinatra::Base

    register Sinatra::Flash
		enable :sessions
		set :session_secret, 'super secret'

helpers do
 def current_user
   @current_user ||= User.get(session[:user_id])
 end
end

  get '/spaces' do
  	p @spaces = Space.all
  	erb :homepage
	  end

	get '/spaces/new' do
	  erb :'spaces/new'
	end

	# post '/spaces' do
	#   Space.create(name: params[:name],
 #                 location: params[:location],
 #                 description: params[:description],
 #                price_per_night: params[:price_per_night], available_from: params[:available_from], available_to: params[:available_to])
	#   redirect to('/spaces')
	# end


	post '/spaces' do 
	  space = Space.create(name: params[:name],
	                		location: params[:location],
	                		description: params[:description],
	                		price_per_night: params[:price_per_night],
	                		available_from: params[:available_from], 
	                		available_to: params[:available_to])
	  if current_user == nil
	  	user = User.new(email: params[:email],
									password: params[:password],
									password_confirmation: params[:password_confirmation])
	  else 
	  	user = current_user
		end
		user.spaces << space
		user.save
		redirect to('/spaces')
	end

	get '/users/new' do
		@user = User.new
		erb :'users/new'
	end

	post '/users' do
		@user = User.new(email: params[:email],
								password: params[:password],
								password_confirmation: params[:password_confirmation])
    if @user.save
		session[:user_id] = @user.id
    redirect to('/spaces')
	  else
			flash.now[:errors] = @user.errors.full_messages
			erb :'users/new'
		end
	end

	get '/sessions/new' do
		erb :'sessions/new'
	end

	post '/sessions' do
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			redirect to ('/spaces')
		else
			flash.now[:errors] = ['The email or password is incorrect']
			erb :'sessions/new'
		end
	end
	

  # start the server if ruby file executed directly
  run! if app_file == $0
end
