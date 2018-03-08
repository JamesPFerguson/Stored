class BuildingsController < ApplicationController

  get '/buildings' do
    s_user
    @buildings = @user.buildings
    erb :'/buildings/index'
  end

  get '/buildings/new' do
    erb :'/buildings/new'
  end

  get '/buildings/:id' do
    @building = Building.find(params[:id])
    @containers = @building.containers

    if @building.user == current_user
      erb :'/buildings/show'
    else
      redirect :"/error"
    end
  end

  get '/buildings/:id/edit' do
    s_user

    erb :'/buildings/edit'
  end

  patch '/buildings/:id/' do
    s_user

    redirect "/buildings/#{@building.id}"
  end

  delete '/buildings:id' do
    s_user

    redirect "/buildings/index"
  end


end
