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
  
  
  delete '/tweets/:id' do 
    Tweet.destroy(params[:id])
    redirect to '/tweets'
  end 
  
  
  get '/tweets/:id/edit' do 
    @tweet = Tweet.find(params[:id])
    if @tweet.user_id == current_user.id 
      erb :'tweets/edit_tweet'
    else 
      flash[:message] = "You cannot edit other people's tweets."
      redirect to "/tweets/#{@tweet.id}"
    end 
  end 
  
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:content])
    redirect to "/tweets/#{@tweet.id}"
  end 
    
      
 
    

end
