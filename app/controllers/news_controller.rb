class NewsController < ApplicationController

  # CREATE
  get '/news/new' do
    if logged_in?
      erb :'/news/create_news'
    else
      redirect to '/news'
    end
  end

  post '/news' do
    if authorized?
      validate_news
      @news = News.new
      if @errors.empty?
        @news.date = params[:date]
        @news.content = params[:content]
        @news.url = params[:url]
        @news.image_url = params[:image_url]
        @news.save
        redirect to "/news"
      else
        erb :'/news/create_news'
      end
    else
      flash[:message] = "This account is not authorized to create a news item."
      redirect to "/news"
    end
  end

  # READ
  get '/news' do
    @news = News.where("date <= ?", Date.today).order(:date).reverse
    erb :'/news/news_index'
  end

  get '/news/pending' do
    if logged_in?
      @news = News.where("date > ?", Date.today).order(:date)
      erb :'/news/news_index'
    else
      redirect to '/news'
    end
  end

  # UPDATE
  get '/news/:id/edit' do
    if logged_in?
      @news = News.find_by(id: params[:id])
      erb :'/news/edit_news'
    else
      redirect to '/news'
    end
  end

  patch '/news/:id' do
    if authorized?
      validate_news
      @news = News.find_by(id: params[:id])
      if @errors.empty?
        @news.date = params[:date]
        @news.content = params[:content]
        @news.url = params[:url]
        @news.image_url = params[:image_url]
        @news.save
        flash[:message] = "Successfully updated news item!"
        redirect to "/news"
      else
        erb :'/news/edit_news'
      end
    else
      flash[:message] = "This account is not authorized to edit a news item."
      redirect to "/news"
    end
  end

  # DELETE
  delete '/news/:id/delete' do
    if authorized?
      validate_news
      @news = News.find_by(id: params[:id])
      if @errors.empty?
        @news.destroy
        flash[:message] = "BALEETED!"
        redirect to '/news'
      else
        erb :'/news/edit_news'
      end
    else
      flash[:message] = "This account is not authorized to delete a news item."
      redirect to "/news"
    end
  end

  private

  def validate_news
    @errors = {}
    @user = current_user

    if params[:date]
      if params[:date].empty?
        @errors[:date] = "Date can't be empty!"
      elsif !/^\d{4}-\d{2}-\d{2}$/.match(params[:date])
        @errors[:date] = "Date format must be yyyy-mm-dd!"
      end

      if params[:content].empty?
        @errors[:content] = "Content can't be empty!"
      elsif News.find_by(date: params[:date], content: params[:content], url: params[:url], image_url: params[:image_url])
        @errors[:content] = "News item already exists."
      end
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
