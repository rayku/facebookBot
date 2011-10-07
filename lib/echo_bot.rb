require 'rubygems'
require 'yaml'
require 'xmpp4r-simple'

credentials = YAML.load_file('configs.yml')[:facebook]
jabber = Jabber::Simple.new credentials[:username], credentials[:password]

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