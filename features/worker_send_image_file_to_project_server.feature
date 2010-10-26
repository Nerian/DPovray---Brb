Feature: Worker send image file to project server
  In order to deliver the image to Project Server
  As a Worker
  I want to be able to send the rendered image file over the network to the Project Server

Scenario: Worker send image file to project server
  	Given I receive a job
	And I ask for a .pov file 	
	And I run povray
	When I send the partial image to project server
  	Then I should see "Connection with server stablished"
	And I should see "Image successfully sent"




  
