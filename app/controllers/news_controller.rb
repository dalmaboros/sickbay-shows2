class NewsController < ApplicationController

  get '/news' do
    @news = News.all
    erb :'/news/news_index'
  end

  # CREATE
  get '/news/new' do
    #
  end

  post '/news/new' do
    #
  end

  # UPDATE
  get '/news/:id/edit' do
    #
  end

  patch '/news/:id/edit' do
    #
  end

  delete '/news/:id/delete' do
    #
  end

end
