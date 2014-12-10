require 'sinatra'
require 'data_mapper'
require 'haml'
require 'csv'
#### Changed By sibu #######
# Controller Class

  
set :public, File.dirname(__FILE__) + '/public'

DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/intern_sibu_editedfinal.db")

@@filename
@@tempfile
@@target
@@f2

class Intern

	include DataMapper::Resource
		property :id, Serial
		property :intern_name, Text,  :required => true
		property :profile, Text,      :required => true
		property :working_on , Text,  :required => true
                property :working_with ,Text, :required =>true 
		property :created, DateTime
		property :skills_Added,Csv
		property :image_add, Text
		

end


#class Image
 #  include DataMapper::Resource 
  
  # property :Imageid,Serial
  # property :path,   FilePath, :required => true
   #property :md5sum, String,   :length => 32, :default => lambda { |r, p| Digest::MD5.hexdigest(r.path.read) if r.path }
  
#belongs_to :Intern 
#end




DataMapper.finalize.auto_upgrade!

get '/' do
       # @target="/img/{#filename}"
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
	erb :print
end
end
get '/add_intern' do
#Edited using branch
	@title = "Add Intern Detail"
	erb :add_intern
end

post '/add_intern' do
##########################################################3
if params[:pic]

filename = params[:pic][:filename]
save_path = "/img/#{params[:pic][:filename]}" 
end
 

#if params[:pic]
#  filename = params[:pic][:filename]
 # tempfile = params[:pic][:tempfile]
  
 # target = "./public/img/#{filename}"
  #File.open(target, 'wb') {|f| f.write tempfile.read }   
  #f3= "#{filename}"
	  
  #File.open(target, 'wb') {|f| f.write tempfile.read }  #Block to define the operation 
  #f3=f2.write
  #f2.close	
  #end 

Intern.create(:intern_name => params[:intern_name], :profile => params[:profile], :working_on => params[:working_on], 
:working_with=>params[:working_with],:created => Time.now, :skills_Added => params[:Skills_Added],:image_add=>save_path)

#Image.create(:path => [:path])  

 redirect '/'
end

get '/view/:id' do

  #tempfile = params[:pic]
  #target = "public/media/image/#{tempfile}"

 #f2= File.open(target, 'wb') 

#content_type "image/jpeg"
#filename = params[:pic] 
#Intern.read(@interns,filename)



@internal=Intern.first(:id =>params[:id])
#@display=intern.display(:image_add =>f2)
erb :view
end

post '/view/:id' do


if params[:pic]
  filename = params[:pic][:filename]
  tempfile = params[:pic][:tempfile]
  target = "public/media/image/#{filename}"
  f2= File.open(target, 'wb') {|f| f.write tempfile.read } 
  @imagepath=target

end

#@image_path=target

#@display=internal.first(:image_add =>f2)

#@query= @interni.select (@display from interns)
 
# filename= params[:pic]
 # target = "public/media/image/#{filename}"

 #f2= File.open(target, 'wb') {|f| f.write filename.read }  #Block to define the operation 

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
##under construction###

	if params.has_key?(:update)
		
        file=params[:file] [:update]
	save_paths="/img/#{params[:file][:update]}"

		intern = Intern.first(:id => params[:id])
		#image=Image.first(:Imageid=>params[:Imageid])
	
		intern.update(:intern_name => params[:intern_name], :profile => params[:profile], :working_on => params[:working_on], 
		:working_with=>params[:working_with],:created => Time.now,:skills_Added =>params[:skills_Added], :image_add=>save_paths	)
		
		#image.update(:path => [:path])
		redirect '/'
	else
		redirect '/'
	end
end
