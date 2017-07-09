class UsersController < ApplicationController
  # use Rack::Flash

  # CREATE
  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if !params[:username].empty? && !params[:email].empty? && !params[:password].empty? && params[:password] === params[:confirm_password] && !User.find_by(username: params[:username])
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      if @user.save
        session[:user_id] = @user.id
        redirect to '/dashboard'
      else
        redirect to '/signup'
      end
    else
      redirect to '/signup'
    end
  end

  get '/login' do
    # binding.pry
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
      # flash[:message] = "Successfully logged in!"
      # binding.pry
      redirect to '/dashboard'
    else
      # flash[:message] = "Something went wrong. Try again."
      # binding.pry
      redirect '/login'
    end
  end

  # READ


  # EDIT
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
      redirect to '/settings'
    else
      redirect to '/settings'
    end
  end

  patch '/password' do
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
    @user = current_user
    if logged_in? && @user.authenticate(params[:password])
      @user.destroy
      session.clear
      redirect to '/backdoor'
    else
      redirect to "/settings"
    end
  end

  # ETC...

  get '/backdoor' do
    if !logged_in?
      erb :'/users/backdoor'
    else
      redirect to '/dashboard'
    end
  end

  get '/dashboard' do
    # binding.pry
    if logged_in?
      erb :'/users/dashboard'
    else
      redirect to '/'
    end
  end

  get '/logout' do
    session.clear if logged_in?
    redirect to '/backdoor'
  end

end
