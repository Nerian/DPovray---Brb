Feature: Worker retrieves job file
	In order to render using Povray
  	As a worker
  	I want to be able to retrieve a .pov file
  	So I can render the scene

	Scenario: worker success in retrieving a .pov file
	  Given I have a Job
	  When I ask for a .pov file
	  Then I should see "Asking for .pov file"
	  And I should see "Received marshaled .Pov file"
	  And I should see "Unmarshaling .pov file"
	  And I should see ".Pov file ready"
	
	
	
	
	
	

  
