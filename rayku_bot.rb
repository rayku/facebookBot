class RaykuBot
  
  def self.tutors
    access_token = 'AAAB3EIZBtPSkBALxoVyNobQqiTTQAbWt6kFPzGhXFpGcD9s6EwIXmmHIW1qujdABeBluXOzYk9sn6kVxUbcNq6uR2ZAYbLutZBhhABFkgZDZD'
    online_friends_query = "SELECT uid, name, pic_square FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND online_presence != 'offline'"
    MiniFB.fql(access_token, online_friends_query)
  end
  
  def self.deliver
    
  end

end