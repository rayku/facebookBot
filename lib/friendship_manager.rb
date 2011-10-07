require 'rubygems'
require 'yaml'
require './lib/friendship_bot'

class FriendshipManager
  @queue = :accept_friendships
  @credentials = YAML.load_file('configs.yml')[:facebook]
  
  def self.perform
    bot = FriendshipBot.new
    bot.accept_friends(@credentials[:username], @credentials[:password])
  end
end