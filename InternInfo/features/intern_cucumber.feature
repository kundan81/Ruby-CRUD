Feature: Intern Information Displaying, Adding, Editing & Deleting
	In order to make users feel comfortable on my website
	As the website owner
	I want to greet them appropriately

Scenario: First time viewing this web Application
	Given I am viewing "/add_intern"	
	When I fill in "intern_name" with "kundan"
	And I fill in "profile" with "developer"
	And I fill in "working_on" with "ruby"
	And I fill in "skill" with "c,java,php"
	And I press on Button "add"
	Then I am viewing "index".
