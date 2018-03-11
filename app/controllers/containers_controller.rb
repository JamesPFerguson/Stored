class ContainersController < ApplicationController

  get '/containers' do
    s_user
    @containers = @user.containers
    erb :'/containers/index'
  end

  get '/containers/new' do
    s_user
    @containers = @user.containers
    erb :'/containers/new'
  end

  post '/containers' do
    if params[:room].empty?
      flash[:message] = "containers must belong to a room"
      redirect "/containers/new"
    elsif params[:container] != ""
      room = room.find_by(name: params["room"])
      container = container.find_or_create_by(name: params[:container])
      if !room.containers.include?(container)
        room.containers << container
      end
      redirect "/containers/#{container.id}"
    else
      flash[:message] = "Please enter a valid name"
      redirect "/containers/new"
    end
  end

  get '/containers/:id' do
    @container = Container.find(params[:id])
    @building = @container.building
    @room = @container.room
    @things = Container.things
    if current_user.containers.include?(@container)
      erb :'/containers/show'
    else
      redirect :"/error"
    end
  end

  get '/containers/:id/edit' do
    s_user

    erb :'/containers/edit'
  end

  patch '/containers/:id/' do
    s_user

    redirect "/containers/#{@room.id}"
  end

  delete '/containers:id' do
    s_user

    redirect "/containers/index"
  end
end
