class MessagesController < ApplicationController

  get '/messages' do
    if is_logged_in?
      @messages = Message.all
      erb :'/messages/messages'
    else
      redirect '/users/login'
    end
  end
  
  get '/messages/new' do
    if is_logged_in?
      erb :'/messages/new'
    else
      redirect '/login'
    end
  end
  
  post '/messages' do
    if is_logged_in?
      if params[:content].empty?
        redirect '/messages/new'
      else
        @message = Message.new(:content => params[:content], :user_id => session[:user_id])
        @message.save
      end
    else
      redirect '/login'
    end
  end
  
  get '/messages/:id' do
    if is_logged_in?
      @message = Message.find(params[:id])
      erb :'/messages/show_message'
    else
      redirect '/login'
    end
  end

  post '/messages/:id/delete' do
    @message = Message.find(params[:id])
    if is_logged_in?
      if @message.user_id == current_user.id
        @message.delete
        redirect '/messages'
      else
        redirect '/messages'
      end
    else
      redirect "/login"
    end
  end
  
end
