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
  

  get '/tweets/:id/edit' do 
    @tweet = Tweet.find(params[:id])
    if  !logged_in?
      redirect to '/login'
    elsif @tweet.user_id != current_user.id
      flash[:message] = "You cannot edit other people's tweets."
      redirect to "/tweets/#{@tweet.id}"
    else   
      erb :'tweets/edit_tweet'
    end 
  end 
  
  
  patch '/tweets/:id' do 
    @tweet = Tweet.find(params[:id])
    if !params[:content] == ""
      @tweet.update(params)
      flash[:message] = "Tweet successfully updated."
      redirect to "/tweets/#{@tweet.id}"
    else 
      flash[:message] = "Please enter content to update tweet."
      redirect to "/tweets/#{@tweet.id}/edit"
    end 
  end 
    
    
  delete '/tweets/:id' do 
    if @tweet.user_id == current_user.id
      Tweet.destroy(params[:id])
      flash[:message] = "Tweet successfully deleted."
    else 
      flash[:message] = "You cannot delete other people's tweets."
    end 
    redirect to '/tweets'
  end 
      
 
    

end
