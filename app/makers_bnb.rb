ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  use Rack::MethodOverride
  set :session_secret, 'super secret'

  helpers do
    def current_user_helper
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/spaces/filter' do
    @spaces = Space.filter(params)
    erb :homepage
  end

  get '/spaces' do
    @spaces = Space.all
    erb :homepage
  end

  get '/spaces/new' do
    current_user_helper
    erb :'spaces/new'
  end

  post '/spaces' do
    space = Space.create(params)
    if !current_user_helper
      user = User.new(params)
    else
      user = current_user_helper
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
    @user = User.new(params)
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
    user = User.authenticate(params)
    if user
      session[:user_id] = user.id
      redirect to ('/spaces')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'goodbye!'
    redirect to ('/spaces')
  end

  get ('/') do
    redirect to ('/spaces')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
