Feature: Worker start render
  In order to get a image
  As a Worker
  I want to run povray and get an image

	Scenario: Worker render a pov file
	  Given I receive a job
	  When I run povray
	  Then I should see "Povray render started"
	  And I should see "Povray render completed"
	
	
	

	

  
