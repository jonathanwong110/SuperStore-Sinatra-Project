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
        @item.save
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
      erb :'/items/edit_item'
    else
      redirect '/login'
    end
  end
  
  patch '/items/:id' do
    @item = Item.find(params[:id])
     if !params[:title].empty? || !params[:price].empty? || !params[:description].empty?
      @item.update(:title => params[:title], :price => params[:price], :description => params[:description])
      @item.save
      redirect "/items/#{params[:id]}"
    else
      redirect "/items/#{params[:id]}/edit"
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
