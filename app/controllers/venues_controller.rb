class VenuesController < ApplicationController

  get '/venues' do
    @venues = Venue.order(:name)
    erb :'/venues/venues_index'
  end

  # CREATE
  get '/venues/new' do

  end

  post '/venues/new' do

  end

  # READ
  get '/venues/:id' do
    @venue = Venue.find_by(id: params[:id])
    erb :'/venues/show_venue'
  end

  # EDIT
  get '/venues/:id/edit' do
    @venue = Venue.find_by(id: params[:id])
    erb :'/venues/edit_venue'
  end

  patch '/venues/:id' do
    @venue = Venue.find_by(id: params[:id])
    # binding.pry
    @venue.name = params[:name] if params[:name] != @venue.name
    @venue.save
    redirect to "/venues/#{@venue.id}"
  end

  # DELETE
  delete '/venues/:id/delete' do
    @venue = Venue.find_by(id: params[:id])
    @venue.destroy
    redirect to '/venues'
  end

end
