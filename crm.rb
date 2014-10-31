require 'sinatra'
require 'data_mapper'
require_relative 'rolodex'

DataMapper.setup(:default, "sqlite3:database.sqlite3")


$rolodex = Rolodex.new


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

# turn this line into columns for the tables	attr_accessor :id, :first_name, :last_name, :email, :note
	
# 	def initialize(first_name, last_name, email, note)
# 		@first_name = first_name
# 		@last_name = last_name
# 		@email = email
# 		@note = note
# 	end


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
	@contact = $rolodex.find_contact(params[:id].to_i)
	if @contact
		@contact.first_name = params[:first_name]
		@contact.last_name = params[:last_name]
		@contact.email = params[:email]
		@contact.note = params[:note]	

		redirect to("/contacts")	
	else
		raise Sinatra::NotFound
	end
end


delete "/contacts/:id" do
	@contact = $rolodex.find(params[:id].to_i)
	if @contact
		$rolodex.delete_contact(@contact)
		redirect to("/contacts")
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
	@contacts = Contact.all
	erb :contacts
end

post '/contacts' do
	contact = Contact.create(
		:first_name => params[:first_name],
		:last_name => params[:last_name],
		:email => params[:last_name],
		:note => params[:note]
		)
	redirect to('/contacts')
end

