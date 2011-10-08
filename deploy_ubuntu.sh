puppet apply deploy.pp
export PATH=$PATH:/var/lib/gems/1.8/bin
QUEUE=* rake resque:work &
ruby lib/echo_bot.rb &
rackup config.ru
