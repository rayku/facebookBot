require 'sinatra'

get '/' do
  erb :index
end

get '/bot_enabled' do
  redirect to ('/not_ok') unless (request.referer =~ /facebook.com/)
  @enabled = params[:action] == '1'
  erb :bot_enabled
end

get '/not_ok' do
  erb :not_ok
end