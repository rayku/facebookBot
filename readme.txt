Install instructions
If you use Ruby 1.9.2 and xmpp4r 0.8.8 you will get some kind of syntax errors in /var/lib/gems/1.9.1/gems/xmpp4r-simple-0.8.8/lib/xmpp4r-simple.rb around 441 line

You need to change this:
      roster.add_presence_callback do |roster_item, old_presence, new_presence|
        simple_jid = roster_item.jid.strip.to_s
        presence = case new_presence.type
                   when nil: new_presence.show || :online
                   when :unavailable: :unavailable
                   else
                     nil
                   end



Into this:
      roster.add_presence_callback do |roster_item, old_presence, new_presence|
        simple_jid = roster_item.jid.strip.to_s
        presence = case new_presence.type
                   when nil
                       new_presence.show || :online
                   when :unavailable
                        :unavailable
                   else
                     nil
                   end




Another bug ?

In /usr/local/lib/ruby/1.9.1/rexml/source.rb around 214 line change This


    def match( pattern, cons=false )
      rv = pattern.match(@buffer)
      @buffer = $' if cons and rv
      while !rv and @source
        begin
          @buffer << readline
          rv = pattern.match(@buffer)
          @buffer = $' if cons and rv
        rescue
          @source = nil
        end
      end
      rv.taint
      rv
    end

Into this:

    def match( pattern, cons=false )
      @buffer=@buffer.force_encoding('utf-8')
      rv = pattern.match(@buffer)
      @buffer = $' if cons and rv
      while !rv and @source
        begin
          @buffer << readline
          rv = pattern.match(@buffer)
          @buffer = $' if cons and rv
        rescue
          @source = nil
        end
      end
      rv.taint
      rv
    end

