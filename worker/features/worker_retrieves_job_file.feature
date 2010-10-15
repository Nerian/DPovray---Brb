Feature: Worker retrieves job file
  	As a worker
  	I want to be able to retrieve a .pov file of a Job.
  	So I can render the scene

	Scenario: worker retrieves a .pov file
	  Given I have a Job
	  When I ask for a .pov file 
	  Then I should receive a .pov file
	
	Scenario: worker could not retrieve .pov file
	  Given I have a Job
	  When I ask for a .pov file	  
	  Then should not receive null
	
	
	
	
	
	

  
