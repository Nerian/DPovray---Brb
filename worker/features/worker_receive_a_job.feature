# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

Feature: Worker receive a job  

	As a worker
	I want to be able to receive jobs   
	So that I can render a Povray scene
		
	Scenario: Worker receives a Job
	  When I receive a job
	  Then I should see "Received a new Job"
	  And I should see "Unmarshaling the Object..."
	  And I should see "Unmarshaling completed"
	
	
		


		  
		
		
	
	
	

