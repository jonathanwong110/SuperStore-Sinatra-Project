class MessagesController < ApplicationController

  get '/messages' do
    redirect_if_not_logged_in
    @messages = Message.all
    erb :'/messages/messages'
  end
  
  get '/messages/new' do
    redirect_if_not_logged_in
    erb :'/messages/new'
  end
  
  post '/messages' do
    redirect_if_not_logged_in
    @message = Message.new(:content => params[:content], :recipient => params[:recipient], :user_id => session[:user_id])
    if @message.save
      flash[:message] = "*Message was sent to #{@message.recipient}*"
      redirect "/messages/#{@message.id}"
    elsif params[:content].empty?
      flash[:error] = "*Please enter a message*"
      redirect '/messages/new'
    elsif params[:recipient].empty?
      flash[:error] = "*Please enter a recipient*"
      redirect '/messages/new'
    else params[:recipient] != User.find_by(:username => params[:recipient])
      flash[:error] = "*User does not exist. Please try again*"
      redirect '/messages/new'
    end
  end
  
  get '/messages/:id' do
    redirect_if_not_logged_in
    @message = Message.find(params[:id])
    if @message.user_id == current_user.id || @message.recipient == current_user.username
      @message = Message.find(params[:id])
      erb :'/messages/show_message'
    else
      redirect :'/messages'
    end
  end

  post '/messages/:id/delete' do
    redirect_if_not_logged_in
    @message = Message.find(params[:id])
    if @message.user_id == current_user.id || @message.recipient == current_user.username
      @message.delete
      flash[:message] = "*Deletion of message was successful*"
      redirect '/messages'
    else
      redirect '/messages'
    end
  end
  
end
