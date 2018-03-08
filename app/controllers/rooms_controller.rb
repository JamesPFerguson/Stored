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
    @building = Building.find(params[:id])
    @rooms = @building.rooms

    if @building.user == current_user
      erb :'/buildings/show'
    else
      redirect :"/error"
    end
  end

  get '/buildings/:id/edit' do
    @building = Building.find(params[:id])
    if @building.user == current_user
      erb :'/buildings/edit'
    else
      redirect :"/error"
    end
  end

  patch '/buildings/:id/' do
    @building = Building.find(params[:id])
    @building.update(name: params["building_name"])
    @building.save
    redirect "/buildings/#{@building.id}"
  end

  delete '/buildings:id' do
    @building = Building.find(params[:id])
    @building.delete
    redirect "/buildings/index"
  end

end
