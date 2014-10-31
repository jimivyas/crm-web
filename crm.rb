require 'sinatra'
require 'data_mapper'
DataMapper.setup(:default, "sqlite3:database.sqlite3")

#routes

class Contact
	include DataMapper::Resource
#columns
	property :id, Serial #increments automatically!
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String

end

DataMapper.finalize
DataMapper.auto_upgrade!


get '/' do
	@crm_app_name = "Jimi's CRM"
	erb :index 
end

get '/contacts/new' do
	erb :new_contact
end

get "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :show_contact
	else
		raise Sinatra::NotFound
	end
end



put '/contacts/:id' do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]	
		@contact.save
		redirect to("/contacts")	
	else
		raise Sinatra::NotFound
	end
end


delete "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	if @contacts
		Contact.delete_contact(@contact)
		redirect to("/contacts")
	else
		raise Sinatra::NotFound
	end
end


get '/contacts/:id/edit' do
	@contact = Contact.get(params[:id].to_i)
	if @contact
		erb :edit_contact
	else
		puts :id
		raise Sinatra::NotFound
	end
end



get '/contacts' do
	@contacts = Contact.all
	erb :contacts
end

post '/contacts' do
	@contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:last_name],
		:note => params[:note]
		)
	redirect to('/contacts')
end

