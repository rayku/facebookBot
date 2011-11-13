require 'mini_fb'
require './configs/facebook'
require 'xmpp4r-simple'

class RaykuBot

  @credentials = Facebook::Config

  def self.tutors
    online_friends_query = "SELECT uid, username, email, name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND online_presence != 'offline'"
    MiniFB.fql(@credentials::ACCESS_TOKEN, online_friends_query)
  end

  def self.deliver(to, message)
    @jabber ||= Jabber::Simple.new(@credentials::USERNAME[:chat], @credentials::PASSWORD)
    @jabber.deliver("-#{to}@chat.facebook.com", message)
  end
end
