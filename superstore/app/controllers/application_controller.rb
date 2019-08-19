require 'rack-flash'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash, :sweep => true
    set :session_secret, "secret"
  end
  
  get '/' do
    if is_logged_in?
      redirect '/items'
    else
      erb :index
    end
  end
  
  helpers do
    
    def is_logged_in?
      !!session[:user_id]
    end
    
    def current_user
      User.find(session[:user_id])
    end
      
  end
  
end
