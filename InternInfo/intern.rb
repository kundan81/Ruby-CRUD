require 'sinatra'
require 'data_mapper'
require 'pry'
require 'pry-nav'

DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/intern_info.db")
class Intern
	include DataMapper::Resource
		property :id, Serial
		property :intern_name, Text, :required => true
		property :profile, Text, :required => true
		property :working_on , Text, :required => true
		property :skill, Text, :required => true
		property :intern_image, Text

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
	if params[:intern_image]
		@filename= params[:intern_image][:filename]
		save_path = "/img/#{params[:intern_image][:filename]}" 
	end
	Intern.create(:intern_name => params[:intern_name], :profile => params[:profile], :working_on => params[:working_on], 
		:skill => params[:skill], :intern_image => save_path, :created => Time.now)
    redirect '/'
end

get '/view/:id' do
@internal=Intern.first(:id =>params[:id])
erb :view
end

post '/view/:id' do
	if params[:intern_image]
		filename = params[:intern_image][:filename]
		tempfile = params[:intern_image][:tempfile]
		target = "public/media/image/#{filename}"
		f2= File.open(target, 'wb') {|f| f.write tempfile.read } 
		@imagepath=target
	end
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