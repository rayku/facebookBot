require File.dirname(__FILE__) + '/spec_helper'

describe "RaykuBot WebServer" do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  before(:each) do
    Resque.stub(:enqueue)
  end

  it "should respond to /" do
    get '/'
    last_response.should be_ok
  end
  
  describe "enabling the bot" do
    context "requests not coming from facebook" do
      before(:each) do
        get '/bot_enabled', {}, 'Referer' => 'not_facebook'
        follow_redirect!
      end
      
      it "should should render /not_ok" do
        last_request.url.should include 'not_ok'
      end
      
      it"should warn the user about it" do
        last_response.body.should include 'The only way to activate the bot is adding it as a friend in facebook.'
      end      
    end
    
    context "request coming from facebook" do      
      context "the user adds raykuBot as friend" do
        it "should tell the user about the friendship" do
          get '/bot_enabled', {:action => '1'}, {'HTTP_REFERER' => 'http://www.facebook.com'}
          last_response.body.should include 'Thank you for adding RaykuBot as your friend in facebook. You will start receiving notifications soon.'
        end
        
        it "should tell the friendship manager to accept the friendship" do
          Resque.should_receive(:enqueue).with(FriendshipManager)
          get '/bot_enabled', {:action => '1'}, {'HTTP_REFERER' => 'http://www.facebook.com'}
        end
      end
      
      context "the user doesn't add raykuBot as friend" do
        it "should tell the user about the friendship not happening" do
          get '/bot_enabled', {:action => '0'}, {'HTTP_REFERER' => 'http://www.facebook.com'}
          last_response.body.should include 'You gave up on adding the RaykuBot as your friend. You will not receive notifications unless you add the bot as your friend.'
        end

        it "should not tell the friendship manager to accept the friendship" do
          Resque.should_not_receive(:enqueue)
          get '/bot_enabled', {:action => '0'}, {'HTTP_REFERER' => 'http://www.facebook.com'}
        end
      end
    end
  end
  

  describe 'retrieving the the tutors' do
    before(:each) do
      @users = double()
      RaykuBot.stub(:tutors) { @users }
    end
    
    it "delegates to the raykubot" do
      RaykuBot.should_receive(:tutors)
      get '/tutor'
    end
    
    it "parses the results to json" do
      @users.should_receive(:to_json)
      get '/tutor'
    end
    
    it "renders the tutors as json" do
      get '/tutor'
      last_response.headers['Content-Type'].should include 'application/json'
    end
  end
  
  describe 'messaging a tutor' do
    before(:each) do
      RaykuBot.stub(:deliver)
    end
    
    it 'posts the message to the tutor' do
      post '/tutor/123/message'
      last_response.should be_ok
    end
    
    it "does not accept a blank tutor" do
      post '/tutor//message'
      last_response.should_not be_ok
    end
    
    context "delegating the delivery to the bot" do
      it "delegates to the raykubot" do
        RaykuBot.should_receive(:deliver)
        post '/tutor/123/message'
      end
    end
  end
end