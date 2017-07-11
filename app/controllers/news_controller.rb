class NewsController < ApplicationController

  get '/news' do
    @news = News.all
    erb :'/news/news_index'
  end

end
