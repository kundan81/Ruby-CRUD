require_relative '../intern.rb'
require 'rack/test'
require 'pry'
#require 'spec_helper'
set :public_folder,File.dirname(__FILE__) +'/public'

set :environment, :test
def app
	Sinatra::Application
end

intern = Intern.all
@ip=Intern.create
	describe 'Access using Expectations' do 
	
	include Rack::Test::Methods
	it "should load the Intern page" do	
		#expect([]).to be_empty
		get '/'	
		last_response.status ==200 
	end

	it "should load the add_intern" do	
		#expect([]).to be_empty
#		expect(response.should redirect_to('add_intern')).should raise_error	

		get '/add_intern'
		last_response.status == 200
	end
	it "should load the delete" do	
#		expect(response.should redirect_to('delete')).should raise_error

		get '/delete'
		last_response.status == 200
	end

	it "should display view page" do	
#		expect(response.should redirect_to('view')).should raise_error	
 
		get '/view'
		last_response.status == 200
	end

	it "should store the data into database " do	
#		subject { post :create, @ip({:intern_name => 'sibu', :profile => 'Trainee', :working_on =>'Ruby', 
#:working_with =>'Lalit',:created => Time.now, :skills_Added => 'rfij,rfdc',:image_add =>'s/dc'})
 #}
#		subject.should redirect_to(widget_url(assigns(@ip)))
		post '/add_intern/:id', @ip=({:intern_name => 'sibu', :profile => 'Trainee', :working_on =>'Ruby', 
:working_with =>'Lalit',:created => Time.now, :skills_Added => 'rfij,rfdc',:image_add =>'s/dc'})
		
		
		intern.should_receive(@ip)
		#expect(@ip).to eq(0) 
		last_response.status == 200
	end	
end
