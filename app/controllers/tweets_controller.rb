class TweetsController < ApplicationController
  
  get '/tweets' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/tweets/tweets'
    end
  end
  
  get '/tweets/new' do 
    if !logged_in?
      redirect to '/login'
    else
      erb :'/tweets/new'
    end
  end 
  
  post '/tweets' do 
    if params[:tweet][:content]
    
      @tweet = Tweet.create(params)
      @tweet.user = current_user
      @tweet.save 
      erb :'tweets/show_tweet'
  end 
  
  get '/users/:slug' do 
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end 
    

end
