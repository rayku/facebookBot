require 'rubygems'
require 'xmpp4r-simple'

jabber = Jabber::Simple.new 'raykubot@chat.facebook.com', 'bghtyu123'

loop do  
  begin
    jabber.received_messages do |msg|
      jid = msg.from.strip.to_s
      jabber.deliver(jid, "I'm just a bot. You cannot talk to me.")
    end
  rescue Exception => e
    puts e.to_s
  end
  sleep 1
end