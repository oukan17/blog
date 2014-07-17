require 'sinatra'
require 'sinatra/activerecord'

configure(:development) {set :database, "sqlite3:exampledb.sqlite3"}

require'./models'


set :sessions, true
require 'bundler/setup'
require 'rack-flash'
use Rack::Flash, :sweep => true

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
end


get '/' do
      redirect '/sign-in'
end

get '/sign-in' do
	erb :sign_in
end

post '/sign-in-process' do
@user = User.find_by_email params[:email]
	if @user && @user.password == params[:password] 
		session[:user_id] = @user.id
		flash[:message] ="You have logged in successfully.</br>"
		redirect '/home'
	else
		flash[:message] ="You failed to login.</br>"
		redirect '/sign-in'
	end
end

get '/home' do
	current_user
	erb :home
end

get '/sign_up' do
	erb :sign_up
end

get '/news' do
     erb :news
end

get '/contact' do
    erb :contact
end

get '/about' do
     erb :about
end
    