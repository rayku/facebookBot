require 'rubygems'
require './configs/facebook'
require './lib/friendship_bot'

class FriendshipManager
  @queue = :accept_friendships
  @credentials = Facebook::Config

  def self.perform
    bot = FriendshipBot.new
    bot.accept_friends @credentials::USERNAME[:login], @credentials::PASSWORD
  end
end
