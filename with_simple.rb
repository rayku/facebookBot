require 'rubygems'
require 'xmpp4r-simple'

jabber = Jabber::Simple.new('raykubot@chat.facebook.com', 'bghtyu123')

loop do  
  begin
    jabber.received_messages do |msg|
      jid = msg.from.strip.to_s
      puts "%s said: %s" % [ jid, msg.body ]
      jabber.deliver(jid, "I'm just a bot. You cannot talk to me.")
    end

    jabber.presence_updates do |update|
      jid, status, message = *update
      puts "#{jid} is #{status} (#{message})"
      jabber.send!("<iq id='v3' to='#{jid}' type='get'><vCard xmlns='vcard-temp'/></iq>");
    end
  rescue Exception => e
    puts e.to_s
  end
  sleep 1
end