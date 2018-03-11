class ContainersController < ApplicationController

  get '/containers' do
    if !logged_in?
      redirect "/login"
    else
      s_user
      @containers = @user.containers
      erb :'/containers/index'
    end
  end

  get '/containers/new' do
    if !logged_in?
      redirect "/login"
    else
      s_user
      @containers = @user.containers
      erb :'/containers/new'
    end
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
    @container = Container.find(params[:id])
    @buildings = current_user.buildings
    @building = @container.building
    @room = container.room
    if current_user.containers.include?(@containers)
      erb :'/containers/edit'
    else
      redirect :"/error"
    end
  end

  patch '/containers/:id/' do
    container = Room.find(params[:id])
    room = Room.find(params[:room])
    container.update(name: params["container_name"], room: room)
    container.save
    redirect "/containers/#{container.id}"
  end

  delete '/containers/:id' do
    container = Container.find(params[:id])
    container.delete
    redirect "/containers/index"
  end
end
