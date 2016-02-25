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
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  post '/spaces/filter' do
    session[:filter_from] = params[:filter_from]
    session[:filter_to] = params[:filter_to]
    redirect '/spaces_filtered'
  end

  get '/spaces_filtered' do
    @spaces_old = Space.all
    @spaces = []
    @spaces_old.each do |space|
      if Date.strptime(session[:filter_from], '%Y-%m-%d').to_time.to_i >= space.available_from.to_time.to_i && Date.strptime(session[:filter_to], '%Y-%m-%d').to_time.to_i <= space.available_to.to_time.to_i
        @spaces << space
      end
    end
    p @spaces
    erb :homepage
  end


  get '/spaces' do
    @spaces = Space.all
    erb :homepage
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end


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
    @sign_in = true
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

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'goodbye!'
    redirect to ('/spaces')
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
