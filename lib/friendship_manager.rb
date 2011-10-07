require './lib/friendship_bot'

class FriendshipManager
  @queue = :accept_friendships

  def self.perform
    bot = FriendshipBot.new
    bot.accept_friends('raykubot@rayku.com', 'bghtyu123')
  end
end