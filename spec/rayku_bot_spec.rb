require File.dirname(__FILE__) + '/spec_helper'

describe 'RaykuBot' do
  
  context "returning the online tutors" do
    it "should use MiniFB to perform the query" do
      MiniFB.should_receive(:fql)
      RaykuBot.tutors
    end
    
    it "should send the correct access_token and the correct query" do
      access_token = 'AAAB3EIZBtPSkBALxoVyNobQqiTTQAbWt6kFPzGhXFpGcD9s6EwIXmmHIW1qujdABeBluXOzYk9sn6kVxUbcNq6uR2ZAYbLutZBhhABFkgZDZD'
      query = "SELECT uid, name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND online_presence != 'offline'"
      MiniFB.should_receive(:fql).with(access_token, query)
      RaykuBot.tutors
    end
  end
  
end