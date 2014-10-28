require 'sinatra'

get '/' do
	@crm_app_name = "Jimi's CRM"
	erb :index 
end