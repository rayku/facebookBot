require File.join(File.dirname(__FILE__), '..', 'web.rb')

require 'sinatra'
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false