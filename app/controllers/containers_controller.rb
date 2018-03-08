class ContainersController < ApplicationController

  get '/containers' do
    s_user
    erb :'/containers/index'
  end

  get '/containers/new' do
    s_user


    erb :'/containers/new'
  end

  post '/containers' do
    s_user


    redirect "/containers/#{@container.id}"
  end

  get '/containers/:id' do
    s_user
    erb :'/containers/show'
  end

  get '/containers/:id/edit' do
    s_user

    erb :'/containers/edit'
  end

  patch '/containers/:id/' do
    s_user

    redirect "/containers/#{@building.id}"
  end

  delete '/containers:id' do
    s_user

    redirect "/containers/index"
  end
end
