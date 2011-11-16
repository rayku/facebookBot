require 'rubygems'
require 'sinatra'
require 'configs/facebook'
require 'resque'
require './lib/rayku_bot'
require './lib/friendship_manager'
require './lib/friendship_bot'

get '/' do
  @appid = Facebook::Config::APP_ID
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
  RaykuBot.tutors.map do |tutor|
    tutor[:uid] = tutor[:uid].to_s
    tutor
  end.to_json
end

post '/tutor/:tutor/message' do
  RaykuBot.deliver(params[:tutor], params[:message])
end
