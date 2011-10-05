require 'sinatra'
require 'resque'
require './friendship_manager'

get '/' do
  erb :index
end

get '/bot_enabled' do
  redirect to ('/not_ok') unless (request.referer =~ /facebook.com/)
  @enabled = params[:action] == '1'
  Resque.enqueue(FriendshipManager) if @enabled
  erb :bot_enabled
end

get '/not_ok' do
  erb :not_ok
end