class BuildingsController < ApplicationController

  get '/buildings' do
    s_user
    @buildings = @user.buildings
    erb :'/buildings/index'
  end

  post '/buildings' do
    if params[:building] != ""
      building = Building.create(name: params[:building])
      s_user
      @user.buildings << building
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

  delete '/buildings/:id' do
    @building = Building.find(params[:id])
    @building.delete
    redirect "/buildings"
  end


end
