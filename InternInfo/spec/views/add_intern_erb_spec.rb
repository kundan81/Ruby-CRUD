describe "Adding record to database", :type => :feature do
  before :each do
    Intern.make(:intern_name => 'kundan', :profile => 'developer', :working_on => 'rspec')
  end

  it "add record in database" do
    visit '/sessions/add_intern'
    within("#session") do
      fill_in 'intern_name', :with => 'kundan'
      fill_in 'profile', :with => 'developer'
      fill_in 'working_on', :with => 'rspec'
    end
    click_button 'add'
    expect(page).to have_content 'Success'
  end
end