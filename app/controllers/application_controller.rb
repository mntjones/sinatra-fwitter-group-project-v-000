require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  # USER SECTION -----------

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if user.save
      redirect to 'tweets/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to 'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  

  # TWEET SECTION -----------
  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end


end
