class VenuesController < ApplicationController

  get '/venues' do
    @venues = Venue.order(:name)
    erb :'/venues/venues_index'
  end
end
