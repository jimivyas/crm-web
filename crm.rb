require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

@@rolodex = Rolodex.new

@@rolodex.add_contact(Contact.new("Jimi", "Vyas", "jimipvyas@gmail.com", "super duper cool")

#routes
get '/' do
	@crm_app_name = "Jimi's CRM"
	erb :index 
end

get '/contacts/new' do
	erb :new_contact
end

get '/contacts/0' do
	@contact = @@rolodex.find(0)
	erb :show_contact


get '/contacts' do
	erb :contacts
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	puts params
	redirect to('/contacts')
end

