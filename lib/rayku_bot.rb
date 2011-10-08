require 'mini_fb'
require 'yaml'
require 'xmpp4r-simple'

class RaykuBot
  
  @credentials = YAML.load_file('configs.yml')[:facebook]
  
  def self.tutors
    online_friends_query = "SELECT uid, name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND online_presence != 'offline'"
    MiniFB.fql(@credentials[:accesstoken], online_friends_query)
  end
  
  def self.deliver(to, message)
    @jabber ||= Jabber::Simple.new(@credentials[:username], @credentials[:password])
    @jabber.deliver("-#{to}@chat.facebook.com", message)
  end
end