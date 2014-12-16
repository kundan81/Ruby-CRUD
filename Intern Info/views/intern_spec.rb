require_relative '../spec_helper'
require '../intern.rb' #__FILE__
#require File.dirname(__FILE__) + '/intern.rb' #directory name and the file name
#require sinatra
require 'rack/test'
require 'pry'
require 'rspec'
#require 'exceptional'

#use Rack::Exceptional, API_KEY if ENV['RACK_ENV'] == 'production' #for deprection errors i added
#require intern

set :enviornment , :test #A symbol specifying the deployment environment; typically set to one of :development, :test, or :production. 
set :raise_errors,true
	def app #check this block
		Sinatra::Application
	end
 
#test condition
#binding.pry
describe "My Sinatra Application" do

include Rack::Test::Methods #for methods like "get" and "Post"

#it "should access add_intern page" do	

#RSpec.configure do |conf|
#conf.include Rack::Test::Methods 
#DataMapper::setup(:default,"sqlite3://#{Dir.pwd}/intern_sibu_editedfinal.db")

#end 

#binding.pry
it "Should diplay the main page" do

get '/'

last_response.status.should be_ok

end


it "Should access the /add_intenr.rb page" do 


get  '/add_intern'
	
	#puts "I'm here after executing #{"@a"}"
	#before a do  "I'm here after executing add page"   end 
	last_response.status.should be_ok
end

it "Should access delete page" do

 get '/delete'
       last_response.status.should ==200
end

it "Should access  view page" do

 get '/view'
#	before  do  "I'm here after executing view page" end
#	expect(last_response.should be_ok)
	last_response.status.should ==200
end



it "Should post the data into database" do

 post '/add_intern/:id',params={ :id=>"id", :profile=>"profile", :working_with=>"working_with",
				:created=>"created" , :skills_Added=>"skills_Added" , :image_add =>"image_add"
			       }
	assert last_response.status.should ==200
   
   # info[0]['id'].should == :id
   # info[1]['profile'].should == :profile

end
end
