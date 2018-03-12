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
    if !params[:building]
      flash[:message] = "Rooms must belong to a building"
      redirect "/rooms/new"
    elsif params[:room] != ""
      building = Building.find_by(name: params["building"])
      room = Room.find_or_create_by(name: params[:room])
      if !building.rooms.include?(room)
        building.rooms << room
      end
      redirect "/rooms/#{room.id}"
    else
      flash[:message] = "Please enter a valid name"
      redirect "/rooms/new"
    end
  end

  get '/rooms/new' do
    if !logged_in?
      redirect "/login"
    else
      @buildings = current_user.buildings
      erb :'/rooms/new'
    end
  end

  get '/rooms/:id' do
    @room = Room.find(params[:id])
    if current_user.rooms.include?(@room)
    @containers = @room.containers
      erb :'/rooms/show'
    else
      redirect :"/error"
    end
  end

  get '/rooms/:id/edit' do
    @buildings = current_user.buildings
    @room = Room.find(params[:id])
    if current_user.rooms && current_user.rooms.include?(@room)
      erb :'/rooms/edit'
    else
      redirect :"/error"
    end
  end

  patch '/rooms/:id/edit' do
    room = Room.find(params[:id])
    building = Building.find(params[:building])
    room.update(name: params["room_name"], building: building)
    room.save
    redirect "/rooms/#{room.id}"
  end

  delete '/rooms/:id' do
    room = Room.find(params[:id])
    room.delete
    redirect "/rooms"
  end

end
