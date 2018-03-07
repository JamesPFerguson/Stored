class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect '/users/show'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect '/signup'
      flash[:message] = "Please enter valid informtion."
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets"
    end
  end

  get '/login' do
    if logged_in?
      redirect "/users/show"
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/show"
    else
      flash[:message] = "Unable to Log in"
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect "/login"
    else
      redirect "/"
    end
  end



end
