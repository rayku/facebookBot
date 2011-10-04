require File.dirname(__FILE__) + '/spec_helper'

describe "RaykuBot WebServer" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
  
  describe "enabling the bot" do

    describe "requests nome coming from facebook" do
      before(:each) do
        get '/bot_enabled', {}, 'Referer' => 'not_facebook'
        follow_redirect!
      end
      
      it "should should render /not_ok" do
        last_request.url.should =~ /\/not_ok/
      end
      
      it"should warn the user about it" do
        last_response.body.should =~ /The only way to activate the bot is adding it as a friend in facebook./
      end      
    end
    
    describe "request coming from facebook" do      
      it "should tell the user about the friendship" do
        get '/bot_enabled', {:action => '1'}, {'HTTP_REFERER' => 'http://www.facebook.com'}
        last_response.body.should =~ /Thank you for adding RaykuBot as your friend in facebook. You will start receiving notifications soon./
      end
      
      it "should tell the user about the friendship not happening" do
        get '/bot_enabled', {:action => '0'}, {'HTTP_REFERER' => 'http://www.facebook.com'}
        last_response.body.should =~ /You gave up on adding the RaykuBot as your friend. You will not receive notifications unless you add the bot as your friend./
      end
    end
  end
end