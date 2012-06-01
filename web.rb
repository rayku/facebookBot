require 'rubygems'
require 'sinatra'
require './configs/facebook'
require 'resque'
require './lib/rayku_bot'
require './lib/friendship_manager'
require './lib/friendship_bot'

# send job to queue
get '/queue_friendship_worker' do
  Resque.enqueue(FriendshipManager)
  return 'OK'
end

# list of all tutors connected through FB to RaykuBot user
get '/tutor' do
  content_type :json
  RaykuBot.tutors.map do |tutor|
    tutor[:uid] = tutor[:uid].to_s
    tutor
  end.to_json
end

# sends a message to given user through FB chat
post '/tutor/:tutor/message' do
  RaykuBot.deliver(params[:tutor], params[:message])
end
