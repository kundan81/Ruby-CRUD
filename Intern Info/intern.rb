require 'sinatra'
require 'data_mapper'
#### Changed By sibu #######
# Controller Class

DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/intern_sibu_edited.db")
	
class Intern
	include DataMapper::Resource
		property :id, Serial
		property :intern_name, Text,  :required => true
		property :profile, Text,      :required => true
		property :working_on , Text,  :required => true
                property :working_with ,Text, :required =>true 
		property :created, DateTime
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@interns = Intern.all(:order => :created.desc)
	redirect '/add_intern' if @interns.empty?
	erb :index
end
get '/print' do
	puts "Hello"
end

post '/print/:id' do
	if params.has_key?("printing")	
	@print=Intern.first(:id =>params[:id])
        	@two=Intern.first(:intern_name=>params[:intern_name])
	erb :id
end
end
get '/add_intern' do
#Edited using branch
	@title = "Add Intern Detail"
	erb :add_intern
end

post '/add_intern' do
#Edited using branch
	Intern.create(:intern_name => params[:intern_name], :profile => params[:profile], :working_on => params[:working_on], 
		:working_with=>params[:working_with],:created => Time.now)
    redirect '/'
end

get '/delete/:id' do
#Edited using branch
	@intern = Intern.first(:id => params[:id])
	erb :delete
end


post '/delete/:id' do
#Edited using branch
	if params.has_key?("ok")
		intern = Intern.first(:id => params[:id])
		intern.destroy
		redirect '/'
	else
		redirect '/'
	end
end


get '/edit/:id' do
#Edited using branch
	@intern = Intern.first(:id => params[:id])
	erb :edit 
end

post '/edit/:id' do
#Edited using branch
	if params.has_key?("update")
		intern = Intern.first(:id => params[:id])

		intern.update(:intern_name => params[:intern_name], :profile => params[:profile], :working_on => params[:working_on], 
		:working_with=>params[:working_with],:created => Time.now)
		redirect '/'
	else
		redirect '/'
	end
end





