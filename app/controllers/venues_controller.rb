class VenuesController < ApplicationController

  get '/venues' do
    @venues = Venue.order(:name)
    erb :'/venues/venues_index'
  end

  # CREATE
  get '/venues/new' do
    if logged_in?
      erb :'/venues/create_venue'
    else
      redirect to '/venues'
    end
  end

  post '/venues/new' do
    if logged_in?
      if Venue.find_by(name: params[:name])
        redirect to "venues/new"
      else
        @venue = Venue.create(name: params[:name])
        redirect to "venues/#{@venue.id}"
      end
    else
      redirect to '/venues'
    end
  end

  # READ
  get '/venues/:id' do
    @venue = Venue.find_by(id: params[:id])
    erb :'/venues/show_venue'
  end

  # EDIT
  get '/venues/:id/edit' do
    if logged_in?
      @venue = Venue.find_by(id: params[:id])
      erb :'/venues/edit_venue'
    else
      redirect to '/venues'
    end
  end

  patch '/venues/:id' do
    if logged_in?
      @venue = Venue.find_by(id: params[:id])
      @venue.name = params[:name] if params[:name] != @venue.name
      @venue.save
      redirect to "/venues/#{@venue.id}"
    else
      redirect to '/venues'
    end
  end

  # DELETE
  delete '/venues/:id/delete' do
    if logged_in?
      @venue = Venue.find_by(id: params[:id])
      @venue.destroy
      redirect to '/venues'
    else
      redirect to '/venues'
    end
  end

end
