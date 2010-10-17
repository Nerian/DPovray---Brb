# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

Feature: Worker start render
  In order to get a image
  As a Worker
  I want to run povray and get an image

	Scenario: Worker render a pov file
	  Given I receive a job
	  And I ask for a .pov file
	  When I run povray
	  Then I should see "Povray render proccess started"
	  And I should see "Povray command was run"
	  And I should see "Partial image was rendered succefully"
	
	
	

	

  
