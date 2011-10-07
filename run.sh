redis-server /usr/local/etc/redis.conf &
QUEUE=* rake resque:work & 
ruby lib/echo_bot.rb & 
rackup config.ru