class UsersController < ApplicationController

  # CREATE
  get '/users/new' do
    @user = User.new
    erb :'/users/create_user'
  end

  post '/users' do
    validate_signup
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @errors.empty? && @user.save
      session[:user_id] = @user.id
      flash[:message] = "Successfully created account!"
      erb :dashboard
    else
      erb :'/users/create_user'
    end
  end

  # READ?
  get '/login' do
    if !logged_in?
      erb :login
    else
      erb :dashboard
    end
  end

  post '/login' do
    validate_login
    if @user && @errors.empty?
      session[:user_id] = @user.id
      binding.pry
      flash[:message] = "Successfully logged in!"
      erb :dashboard
    else
      # flash[:message] = "Something went wrong. Try again."
      erb :login
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      flash[:message] = "Successfully logged out."
      erb :backdoor
    else
      redirect to '/'
    end
  end

  # UPDATE
  get '/settings' do
    if logged_in?
      @user = current_user
      erb :'/users/edit_user'
    else
      redirect to '/'
    end
  end

  patch '/settings' do
    @user = current_user
    if logged_in? && @user.authenticate(params[:password])
      if @user.username != params[:username] && !params[:username].empty?
        @user.username = params[:username]
      end
      if @user.email != params[:email] && !params[:email].empty?
        @user.email = params[:email]
      end
      @user.save
      flash[:message] = "Successfully updated user!"
      erb :'/users/edit_user'
    else
      flash[:message] = "Could not update user."
      erb :'/users/edit_user'
    end
  end

  patch '/password' do
    @user = current_user
    if logged_in? && @user.authenticate(params[:old_password]) && params[:password] === params[:confirm_password]
      @user.password = params[:password]
      @user.save
      flash[:message] = "Successfully updated password!"
      erb :dashboard
    else
      flash[:message] = "Could not update password."
      erb :'/users/edit_user'
    end
  end

  # DELETE
  delete '/users/:id/delete' do
    @user = current_user
    if logged_in? && @user.authenticate(params[:password])
      @user.destroy
      session.clear
      flash[:message] = "BALEETED!"
      erb :backdoor
    else
      flash[:message] = "Could not delete account."
      erb :'/users/edit_user'
    end
  end

  private

  def validate_signup
    @errors = {}

    if params[:username].empty?
      @errors[:username] = "Username can't be empty!"
    elsif User.find_by(username: params[:username])
      @errors[:username] = "Username is taken!"
    end

    if params[:email] && params[:email].empty?
      @errors[:email] = "Email can't be empty!"
    elsif User.find_by(email: params[:email])
      @errors[:email] = "Email is taken!"
    end

    if params[:password].empty?
      @errors[:password] = "Password can't be empty!"
    elsif params[:password].length < 8 || params[:password].length > 20
      @errors[:password] = "Password must be between 8 - 20 character long"
    end

    if params[:confirm_password] && params[:confirm_password].empty?
      @errors[:confirm_password] = "Please confirm your password!"
    elsif params[:confirm_password] != params[:password]
      @errors[:confirm_password] = "Passwords don't match!"
    end
  end

  def validate_login
    @errors = {}
    @user = User.find_by(username: params[:username])

    if params[:username].empty?
      @errors[:username] = "Username can't be empty!"
    elsif !@user
      @errors[:username] = "Username does not exist!"
    end

    if params[:password].empty?
      @errors[:password] = "Password can't be empty!"
    elsif @user && !@user.authenticate(params[:password])
      @errors[:password] = "Incorrect password."
    end

  end

end
