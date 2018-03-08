class BuildingsController < ApplicationController

  get '/buildings' do
    s_user
    erb :'/buildings/index'
  end

  get '/buildings/new' do
    s_user


    erb :'/buildings/new'
  end

  get '/buildings/:id' do
    s_user
    erb :'/buildings/show'
  end

  get '/buildings/:id/edit' do
    s_user

    erb :'/buildings.edit'
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
