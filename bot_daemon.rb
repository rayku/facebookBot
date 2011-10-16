require 'rubygems'
require 'daemons'

pwd = Dir.pwd
  Daemons.run_proc('web.rb', {:dir_mode => :normal, :dir => "/opt/pids/sinatra"}) do
  Dir.chdir(pwd)
  exec "ruby web.rb"
end
