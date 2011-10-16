require 'rubygems'
require 'daemons'

pwd = Dir.pwd
Daemons.run_proc('lib/echo_bot.rb', {:dir_mode => :normal, :dir => "/opt/pids/facebook_chat"}) do
  Dir.chdir(pwd)
  exec "ruby lib/echo_bot.rb"
end
