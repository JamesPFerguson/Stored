class ThingsController < ApplicationController

  get '/things' do
    if !logged_in?
      redirect "/login"
    else
      s_user
      @things = @user.things
      erb :'/things/index'
    end
  end

  get '/things/new' do
    if !logged_in?
      redirect "/login"
    else
      s_user
      @things = @user.things
      erb :'/things/new'
    end
  end

  post '/things' do
    if params[:container].empty?
      flash[:message] = "things must belong to a container"
      redirect "/things/new"
    elsif params[:thing] != ""
      container = container.find_by(name: params["container"])
      thing = thing.find_or_create_by(name: params[:thing])
      if !container.things.include?(thing)
        container.things << thing
      end
      redirect "/things/#{thing.id}"
    else
      flash[:message] = "Please enter a valid name"
      redirect "/things/new"
    end
  end

  get '/things/:id' do
    @thing = thing.find(params[:id])
    @building = @thing.building
    @container = @thing.container
    @things = thing.things
    if current_user.things.include?(@thing)
      erb :'/things/show'
    else
      redirect :"/error"
    end
  end

  get '/things/:id/edit' do
    @thing = thing.find(params[:id])
    @buildings = current_user.buildings
    @building = @thing.building
    @container = thing.container
    if current_user.things.include?(@things)
      erb :'/things/edit'
    else
      redirect :"/error"
    end
  end

  patch '/things/:id/' do
    thing = container.find(params[:id])
    container = container.find(params[:container])
    thing.update(name: params["thing_name"], container: container)
    thing.save
    redirect "/things/#{thing.id}"
  end

  delete '/things/:id' do
    thing = thing.find(params[:id])
    thing.delete
    redirect "/things/index"
  end

end
