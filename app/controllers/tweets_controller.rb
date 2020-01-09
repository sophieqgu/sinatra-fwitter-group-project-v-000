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
    if !params[:content].empty?
      @tweet = Tweet.create(params)
      @tweet.user = current_user
      @tweet.save 
      redirect to "/tweets/#{@tweet.id}"
    else 
      flash[:message] = "Your tweet cannot be empty."
      redirect to '/tweets/new'
    end 
  end 
  
  
  get '/tweets/:id' do 
    if !logged_in?
      redirect to '/login'
    else
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    end
  end 
 
    

end
