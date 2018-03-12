class BuildingsController < ApplicationController

  get '/buildings' do
    if !logged_in?
      redirect "/login"
    else
      s_user
      @buildings = @user.buildings
      erb :'/buildings/index'
    end
  end

  post '/buildings' do
    if params[:building] != ""
      building = Building.find_or_create_by(name: params[:building])
      if !current_user.buildings.include?(building)
        current_user.buildings << building
      end
      redirect "/buildings/#{building.id}"
    else
      flash[:message] = "Please enter a valid name"
      redirect "/buildings/new"
    end
  end

  get '/buildings/new' do
    erb :'/buildings/new'
  end

  get '/buildings/:id' do
    @building = Building.find(params[:id])
    if @building.user == current_user
    @rooms = @building.rooms
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

  patch '/buildings/:id/edit' do
    if params[:building_name] != ""
      building = Building.find(params[:id])
      building.update(name: params["building_name"])
      building.save
      redirect "/buildings/#{building.id}"
    else
      flash[:message] = "building must have a name"
      redirect "/buildings/#{params[:id]}/edit"
    end
  end

  delete '/buildings/:id' do
    building = Building.find(params[:id])
    building.delete
    redirect "/buildings"
  end


end
