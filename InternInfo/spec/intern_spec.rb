require_relative '../intern.rb' # this load the file you are testing
require_relative 'spec_helper.rb' # It will load the configuration you set in spec_helper.rb
require 'pry'
require 'pry-nav'
require 'pry-stack_explorer'
describe 'Intern Info' do 
	it "should load the home page" do	
		expect([]).to be_empty
		get '/'
		last_response.status == 302
	end
	it "should not load the home page" do	
		expect([]).to be_empty
		get '/add_intern'
		last_response.status == 302
	end
	it "should load add intern details page" do	
		get '/add_intern'
		last_response.status == 302
	end
	it "should load edit details page" do	
		get '/edit'
		last_response.status == 302
	end
	it "should load delete details page" do	
		get '/delete'
		last_response.status == 302
	end
	it "add intern details to the database and then load the home page" do
		#binding.pry
		#tempfile = params['intern_image'][:tempfile]
 		#save_path = FileUtils.copy_file(tempfile.path,"files/#{params['intern_image'][:filename]}")
		post '/add_intern', params = {:intern_name => 'Kundan', :profile => 'Developer', :working_on => 'Ruby', 
										:skill => 'c,java,php'}	
		#post '/add_intern'
		@intern = Intern.first
		expect(@intern.id).to eq(1)														
		expect(@intern.intern_name).to eq('Kundan')			#puts @intern.intern_name
		expect(@intern.profile).to eq('Developer')
		expect(@intern.working_on).to eq('Ruby')
		expect(@intern.skill).to eq('c,java,php')
		last_response.status == 302
	end
	it "Deletes record from database" do
		@intern = Intern.first
		#@id = @intern.id
		#post "/delete/#{@intern.id}", params = {:id => @intern.id, :ok => true}
		#last_response.status == 302		
	end
	
	it "Edit and Update Record of Database" do				
		@intern = Intern.last
		@change_name = 'neeraj'
		@change_profile = 'Design'
		@change_working_on = 'css'
		#post "/edit/#{@intern.id}", params = {:id => @intern.id, :intern_name => "#{@change_name}", :profile => "#{@change_profile}", 
		#:working_on => "#{@change_working_on}", :created => Time.now }
		#last_response.status == 302	
	end
end # End of the line