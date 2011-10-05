redis-server /usr/local/etc/redis.conf &
QUEUE=* rake resque:work & 
rackup config.ru