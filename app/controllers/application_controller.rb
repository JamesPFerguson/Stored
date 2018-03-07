require './config/environment.rb'

class ApplicationController < Sinatra::Base

  #flash[:message] for messages

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "thing_secret"
  end

  get '/' do
    if logged_in?
      redirect "/users/show"
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

    def s_user #sets the instance variable @user to the current user
      @user = current_user
    end
  end

end
