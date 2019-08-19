class ItemsController < ApplicationController
  
  get '/items' do
    if is_logged_in?
      @items = Item.all
      erb :'/items/items'
    else
      redirect '/users/login'
    end
  end
  
  get '/items/new' do
    if is_logged_in?
      erb :'/items/new'
    else
      redirect '/login'
    end
  end
  
  post '/items' do
    if is_logged_in?
      if params[:title].empty? || params[:price].empty? || params[:description].empty?
        redirect '/items/new'
      else
        @item = Item.new(:title => params[:title], :price => params[:price], :description => params[:description], :user_id => session[:user_id])
        if @item.save
          redirect '/items'
        else
          redirect 'items/error'
        end
      end
    else
      redirect '/login'
    end
  end
  
  get '/items/:id' do
    if is_logged_in?
      @item = Item.find(params[:id])
      erb :'/items/show_item'
    else
      redirect '/login'
    end
  end
  
  get '/items/:id/edit' do
    @item = Item.find(params[:id])
    if is_logged_in? && @item.user_id == current_user.id
      @item.save
      erb :'/items/edit_item'
    else
      redirect '/login'
    end
  end
  
  patch '/items/:id/edit' do
    @item = Item.find(params[:id])
     if !params[:title].empty? || !params[:price].empty? || !params[:description].empty?
      @item.update(:title => params[:title], :price => params[:price], :description => params[:description])
      @item.save
      flash[:message] = "Edit successful"
      redirect "/items/#{@item.id}"
    else
      redirect "/items/#{@item.id}/edit"
    end
  end

  post '/items/:id/delete' do
    @item = Item.find(params[:id])
    if is_logged_in?
      if @item.user_id == current_user.id
        @item.delete
        redirect '/items'
      else
        redirect '/items'
      end
    else
      redirect "/login"
    end
  end
  
end
