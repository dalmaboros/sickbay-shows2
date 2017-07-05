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

  # DELETE

end
