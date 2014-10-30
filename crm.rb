require 'sinatra'
require_relative 'contact'
require_relative 'rolodex'

$rolodex = Rolodex.new

$rolodex.add_contact(Contact.new("Jimi", "Vyas", "jimipvyas@gmail.com", "super duper cool"))

#routes

get '/' do
	@crm_app_name = "Jimi's CRM"
	erb :index 
end

get '/contacts/new' do
	erb :new_contact
end

get '/contacts/:id' do
	@contact = $rolodex.find_contact(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]		
	else
		raise Sinatra::NotFound
	end
end

get '/contacts/:id/edit' do
	@contact = $rolodex.find_contact(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		raise Sinatra::NotFound
	end
end



get '/contacts' do
	erb :contacts
end

post '/contacts' do
	new_contact = Contact.new(params[:first_name], params[:last_name], params[:email], params[:note])
	$rolodex.add_contact(new_contact)
	puts params
	redirect to('/contacts')
end

