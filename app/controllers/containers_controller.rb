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
      @buildings = @user.buildings
      @rooms = @user.rooms
      erb :'/containers/new'
    end
  end

  post '/containers' do
    if !params[:room]
      flash[:message] = "containers must belong to a room"
      redirect "/containers/new"
    elsif params[:container] != ""
      room = Room.find(params["room"])
      container = Container.find_or_create_by(name: params[:container])
      if !current_user.containers.include?(container)
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
    if current_user.containers.include?(@container)
    @room = @container.room
    @building = @room.building
    @things = @container.things
      erb :'/containers/show'
    else
      redirect :"/error"
    end
  end

  get '/containers/:id/edit' do
    @container = Container.find(params[:id])
    if current_user.containers.include?(@container)
    @buildings = current_user.buildings
    @building = @container.room.building
    @room = @container.room
      erb :'/containers/edit'
    else
      redirect :"/error"
    end
  end

  patch '/containers/:id/edit' do
    if params["container_name"] == ""
      flash[:message] = "Container name cannot be blank"
      redirect "/containerss/#{container.id}/edit"
    else
      container = Container.find(params[:id])
      room = Room.find(params[:room])
      container.update(name: params["container_name"], room: room)
      container.save
      redirect "/containers/#{container.id}"
    end
  end

  delete '/containers/:id' do
    container = Container.find(params[:id])
    container.delete
    redirect "/containers"
  end
end
