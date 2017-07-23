class VenuesController < ApplicationController

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
      validate_venue
      binding.pry
      if @errors.empty?
        @venue = Venue.create(name: params[:name])
        flash[:message] = "Successfully created venue!"
        redirect to "venues/#{@venue.slug}"
      else
        erb :'/venues/create_venue'
      end
    else
      redirect to '/venues'
    end
  end

  # READ
  get '/venues' do
    @venues = Venue.order("lower(name)")
    erb :'/venues/venues_index'
  end

  get '/venues/:slug' do
    @venue = Venue.find_by_slug(params[:slug])
    erb :'/venues/show_venue'
  end

  # UPDATE
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
      validate_venue
      @venue = Venue.find_by_slug(params[:slug])
      binding.pry
      if @errors.empty?
        @venue.name = params[:name]
        @venue.save
        flash[:message] = "Successfully updated venue!"
        redirect to "/venues/#{@venue.slug}"
      else
        erb :'/venues/edit_venue'
      end
    else
      redirect to '/venues'
    end
  end

  # DELETE
  delete '/venues/:slug/delete' do
    if logged_in?
      @venue = Venue.find_by_slug(params[:slug])
      validate_venue
      if @errors.empty?
        @venue.destroy
        flash[:message] = "BALEETED!"
        redirect to '/venues'
      else
        erb :'/venues/edit_venue'
      end
    else
      redirect to '/venues'
    end
  end

  private

  def validate_venue
    @errors = {}
    @user = current_user

    if params[:name] && params[:name].empty?
      @errors[:venue] = "Venue can't be empty!"
    elsif Venue.find_by(name: params[:name]) && Venue.find_by(name: params[:name]) != Venue.find_by_slug(params[:slug])
      @errors[:venue] = "Venue already exists!"
    end

    if params[:password]
      if params[:password].empty?
        @errors[:password] = "Password can't be empty!"
      elsif @user && !@user.authenticate(params[:password])
        @errors[:password] = "Incorrect password."
      end
    end
  end

end
