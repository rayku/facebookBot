require 'rubygems'
require 'mechanize'

class FriendshipBot
  
  def accept_friends username, password
    @agent = Mechanize.new
    requests_page = login(username, password)
    friendship_requests = requests_page.forms_with(:action => '/ajax/reqs.php')

    friendship_requests.each do |request|
      request.click_button
    end
  end

  private
  def login(username, password)
    page = @agent.get('http://facebook.com/reqs.php')
    form = page.form_with :id => 'login_form'

    form.email = username
    form.pass = password

    form.submit
  end
  
end

