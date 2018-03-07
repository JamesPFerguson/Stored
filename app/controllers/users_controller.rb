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
   erb :'/users/login'
 end



end
