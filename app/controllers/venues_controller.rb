class VenuesController < ApplicationController
  # enable :sessions
  # use Rack::Flash

  get '/venues' do
    @venues = Venue.order("lower(name)")
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
        flash[:message] = "Venue already exists."
        redirect to "venues/new"
      else
        @venue = Venue.create(name: params[:name])
        flash[:message] = "Successfully created venue!"
        redirect to "venues/#{@venue.slug}"
      end
    else
      redirect to '/venues'
    end
  end

  # READ
  get '/venues/:slug' do
    @venue = Venue.find_by_slug(params[:slug])
    erb :'/venues/show_venue'
  end

  # EDIT
  get '/venues/:slug/edit' do
    if logged_in?
      @venue = Venue.find_by_slug(params[:slug])
      erb :'/venues/edit_venue'
    else
      redirect to '/venues'
    end
  end

  patch '/venues/:slug' do
    if logged_in?
      @venue = Venue.find_by_slug(params[:slug])
      @venue.name = params[:name] if params[:name] != @venue.name  && !params[:name].empty?
      @venue.save
      flash[:message] = "Successfully updated venue!"
      redirect to "/venues/#{@venue.slug}"
    else
      redirect to '/venues'
    end
  end

  # DELETE
  delete '/venues/:slug/delete' do
    @user = current_user
    @venue = Venue.find_by_slug(params[:slug])
    if logged_in? && @user.authenticate(params[:password])
      @venue.destroy
      flash[:message] = "BALEETED!"
      redirect to '/venues'
    else
      flash[:message] = "Incorrect password. Could not delete venue."
      redirect to "/venues/#{@venue.slug}/edit"
    end
  end

end
