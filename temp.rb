require 'mechanize'

agent = Mechanize.new

page = agent.get('http://facebook.com/')
form = page.form_with :id => 'login_form'
