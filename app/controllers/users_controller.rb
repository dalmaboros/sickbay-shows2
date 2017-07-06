class UsersController < ApplicationController

  # CREATE
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    binding.pry
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty? && params[:password] === params[:confirm_password]
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/dashboard'
      else
        redirect to '/backdoor'
      end
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/users/login'
    else
      redirect to '/dashboard'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/dashboard'
    else
      redirect to '/login'
    end
  end

  # READ


  # EDIT
  get '/settings' do
    @user = current_user
    erb :'/users/edit_user'
  end

  patch '/settings' do

    @user = current_user
    binding.pry
    if logged_in? && @user.authenticate(params[:password])
      if @user.username != params[:username] && !params[:username].empty?
        @user.username = params[:username]
      end
      if @user.email != params[:email] && !params[:email].empty?
        @user.email = params[:email]
      end
      @user.save
      redirect to '/settings'
    else
      redirect to '/settings'
    end
  end

  patch '/password' do
    binding.pry
    @user = current_user
    if logged_in? && @user.authenticate(params[:old_password]) && params[:password] === params[:confirm_password]
      @user.password = params[:password]
      @user.save
      redirect to '/dashboard'
    else
      redirect to '/settings'
    end
  end

  # DELETE
  delete '/users/:id/delete' do
    binding.pry
    @user = current_user
    @user.destroy
    session.clear
    redirect to '/backdoor'
  end

  get '/backdoor' do
    erb :'/users/backdoor'
  end

  get '/dashboard' do
    binding.pry
    if logged_in?
      erb :'/users/dashboard'
    else
      erb :index
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect to '/backdoor'
  end

end
