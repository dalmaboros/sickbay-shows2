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
    if logged_in?
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
      redirect to '/news'
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
    if logged_in?
      validate_news
      @news = News.find_by(id: params[:id])
      binding.pry
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
      redirect to '/news'
    end
  end

  # DELETE
  delete '/news/:id/delete' do
    @user = current_user
    @news = News.find_by(id: params[:id])
    if logged_in? && @user.authenticate(params[:password])
      @news.destroy
      flash[:message] = "BALEETED!"
      redirect to '/news'
    else
      flash[:message] = "Incorrect password. Could not delete news item."
      redirect to "/news/#{@news.id}/edit"
    end
  end

  private

  def validate_news
    @errors = {}

    if params[:date].empty?
      @errors[:date] = "Date can't be empty!"
    elsif !/^\d{4}-\d{2}-\d{2}$/.match(params[:date])
      @errors[:date] = "Date format must be yyyy-mm-dd!"
    end

    if params[:content].empty?
      @errors[:content] = "Content can't be empty!"
    end

    if News.find_by(date: params[:date], content: params[:content])
      @errors[:content] = "News item already exists."
    end
  end

end
