class RoomsController < ApplicationController

  get '/rooms' do
    if !logged_in?
      redirect "/login"
    else
      s_user
      @rooms = @user.rooms
      erb :'/rooms/index'
    end
  end

  post '/rooms' do
    if params[:building].empty?
      flash[:message] = "Rooms must belong to a building"
      redirect "/rooms/new"
    elsif params[:room] != ""
      binding.pry
      building = Building.find_by(name: params["building"])
      room = Room.create(name: params[:room])
      building.rooms << room
      redirect "/rooms/#{room.id}"
    else
      flash[:message] = "Please enter a valid name"
      redirect "/rooms/new"
    end
  end

  get '/rooms/new' do
    @buildings = current_user.buildings
    erb :'/rooms/new'
  end

  get '/rooms/:id' do
    @room = Room.find(params[:id])
    @containers = @room.containers

    if @room.user == current_user
      erb :'/rooms/show'
    else
      redirect :"/error"
    end
  end

  get '/rooms/:id/edit' do
    @buildings = current_user.buildings
    @room = Room.find(params[:id])
    if @room.user == current_user
      erb :'/rooms/edit'
    else
      redirect :"/error"
    end
  end

  patch '/rooms/:id/' do
    @room= Room.find(params[:id])
    @room.update(name: params["room"], building: params[:building])
    @room.save
    binding.pry
    redirect "/rooms/#{@room.id}"
  end

  delete '/buildings:id' do
    @building = Building.find(params[:id])
    @building.delete
    redirect "/buildings/index"
  end

end
