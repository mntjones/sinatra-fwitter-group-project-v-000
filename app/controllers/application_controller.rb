require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  # USER SECTION -----------

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do
    @user = User.new(username: params[:username], password: params[:password], email: params[:email])
    if @user.save
      session[:id] = @user.id
      redirect to 'tweets/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'users/login'
  end

  post '/login' do
    @user = User.find_by(username: params["username"], password: params["password"])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  # TWEET SECTION -----------
  get '/tweets' do
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get 'tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do
    if !params["tweet"]["content"].empty?
      Tweet.create(content: params["tweet"]["content"])
    end
    erb :'tweets/tweets'
  end

  get 'tweets/:id' do
    @tweet = Tweet.find_by_id(id: params(:id))
    erb :'tweets/show_tweet'
  end

  # HELPERS ---------
  helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end
end
