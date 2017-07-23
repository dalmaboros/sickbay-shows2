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
      flash[:message] = "Successfully logged in!"
      erb :dashboard
    else
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
    if logged_in?
      validate_edit
      if @errors.empty?
        @user.username = params[:username]
        @user.email = params[:email]
        @user.save
        flash[:message] = "Successfully updated user!"
        erb :'/users/edit_user'
      else
        erb :'/users/edit_user'
      end
    else
      redirect to '/'
    end
  end

  patch '/password' do
    if logged_in?
      validate_password
      if @errors.empty?
        @user.password = params[:new_password]
        @user.save
        flash[:message] = "Successfully updated password!"
        erb :'/users/edit_user'
      else
        flash[:message] = "Could not update password."
        erb :'/users/edit_user'
      end
    else
      redirect to '/'
    end
  end

  # DELETE
  delete '/users/:id/delete' do
    if logged_in?
      @user = current_user
      validate_delete
      if @errors.empty?
        @user.destroy
        session.clear
        flash[:message] = "BALEETED!"
        erb :backdoor
      else
        erb :'/users/edit_user'
      end
    else
      redirect to '/'
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
    elsif params[:password].length < 6 || params[:password].length > 20
      @errors[:password] = "Password must be between 6 - 20 characters long"
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

  def validate_edit
    @errors = {}
    @user = current_user

    if params[:username].empty?
      @errors[:username] = "Username can't be empty!"
    elsif User.find_by(username: params[:username]) && User.find_by(username: params[:username]) != @user
      @errors[:username] = "Username is taken!"
    end

    if params[:email].empty?
      @errors[:email] = "Email can't be empty!"
    elsif User.find_by(email: params[:email]) && !@user.email
      @errors[:email] = "Email is taken!"
    end

    if params[:password].empty?
      @errors[:password] = "Password can't be empty!"
    elsif @user && !@user.authenticate(params[:password])
      @errors[:password] = "Incorrect password."
    end
  end

  def validate_password
    @errors = {}
    @user = current_user

    if params[:old_password].empty?
      @errors[:old_password] = "Please enter your current password!"
    elsif @user && !@user.authenticate(params[:old_password])
      @errors[:old_password] = "Incorrect password."
    end

    if params[:new_password].empty?
      @errors[:new_password] = "New password can't be blank!"
    elsif params[:new_password].length < 6 || params[:new_password].length > 20
      @errors[:new_password] = "New password must be between 6 - 20 characters long"
    end

    if params[:confirm_password] && params[:confirm_password].empty?
      @errors[:confirm_password] = "Please confirm your new password!"
    elsif params[:confirm_password] != params[:new_password]
      @errors[:confirm_password] = "Passwords don't match!"
    end
  end

  def validate_delete
    @errors = {}
    @user = current_user

    if params[:delete_password].empty?
      @errors[:delete_password] = "Password can't be empty!"
    elsif @user && !@user.authenticate(params[:delete_password])
      @errors[:delete_password] = "Incorrect password."
    end
  end

end
