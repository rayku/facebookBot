require 'rubygems'
require 'sinatra'
require 'resque'
require 'mini_fb'
require './friendship_manager'
require './rayku_bot'

get '/' do
  erb :index
end

get '/bot_enabled' do
  redirect to('/not_ok') unless (request.referer =~ /facebook.com/)
  @enabled = params[:action] == '1'
  Resque.enqueue(FriendshipManager) if @enabled
  erb :bot_enabled
end

get '/not_ok' do
  erb :not_ok
end

get '/tutor' do
  content_type :json
  RaykuBot.tutors.to_json
end

post '/tutor/:tutor/message' do
  RaykuBot.deliver
end