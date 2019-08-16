class UsersController < ApplicationController
  
  get '/signup' do
    if is_logged_in?
      redirect '/items'
    else
      erb :'/users/signup'
    end
  end
  
  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    if @user.save && @user.username != "" && @user.email != ""
      session[:user_id] = @user.id
      redirect "/items"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if is_logged_in?
      redirect '/items'
    else
      erb :'/users/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/items'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if is_logged_in?
      session.clear
      redirect '/'
    end
  end
  
  get '/users' do
    if is_logged_in?
      @users = User.all
      erb :'/users/users'
    else
      redirect '/users/login'
    end
  end
  
  get '/users/:id' do
    if is_logged_in?
      @user = User.find(params[:id])
      @item = Item.find(params[:id])
      @items = Item.all
      erb :'/users/show_user'
    else
      redirect '/login'
    end
  end
  
end