require 'sinatra'
require 'data_mapper'
DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/intern_info.db")
class Intern
	include DataMapper::Resource
		property :id, Serial
		property :intern_name, Text, :required => true
		property :profile, Text, :required => true
		property :working_on , Text, :required => true

		property :created, DateTime
end
DataMapper.finalize.auto_upgrade!

get '/' do
	@interns = Intern.all(:order => :created.desc)
	redirect '/add_intern' if @interns.empty?
	erb :index
end

get '/add_intern' do
	@title = "Add Intern Detail"
	erb :add_intern
end

post '/add_intern' do
	Intern.create(:intern_name => params[:intern_name], :profile => params[:profile], :working_on => params[:working_on], 
		:created => Time.now)
    redirect '/'
end

get '/delete/:id' do
	@intern = Intern.first(:id => params[:id])
	erb :delete
end

post '/delete/:id' do
	if params.has_key?("ok")
		intern = Intern.first(:id => params[:id])
		intern.destroy
		redirect '/'
	else
		redirect '/'
	end
end

get '/edit/:id' do
	@intern = Intern.first(:id => params[:id])
	erb :edit 
end

post '/edit/:id' do
	if params.has_key?("update")
		intern = Intern.first(:id => params[:id])
		intern.update(:intern_name => params[:intern_name], :profile => params[:profile], :working_on => params[:working_on], 
			:created => Time.now)
		redirect '/'
	else
		redirect '/'
	end
end

get '/update/:id' do
	@intern = Intern.first(:id => params[:id])
end
