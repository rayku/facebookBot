require 'rubygems'
require 'daemons'

pwd = Dir.pwd
  Daemons.run_proc('friendship_worker', {:dir_mode => :normal, :dir => "/opt/pids/friendship_worker"}) do
  Dir.chdir(pwd)
  exec "QUEUE=* rake resque:work"
end
