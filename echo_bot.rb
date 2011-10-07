require 'rubygems'
require 'blather/client'

setup 'raykubot@chat.facebook.com', 'bghtyu123'

message :chat?, :body do |m|
  write_to_stream Blather::Stanza::Message.new(m.from, "I'm just a bot. You cannot talk to me.")
end