require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

get '/' do
	@crm_app_name = "Jimi's CRM"
	erb :index 
end

get '/contacts' do
	@contacts = []
	@contacts << Contact.new("Jimi", "Vyas", "jimipvyas@gmail.com", "cool guy")
	@contacts << Contact.new("Jam", "Jones", "jjones@gmail.com", "not cool")
	erb :contacts
end
