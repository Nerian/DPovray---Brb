DPovray – Distributed Povray [![](http://stillmaintained.com/Nerian/DPovray.png)](http://stillmaintained.com/Nerian/DPovray)
===

DPovray is Ruby application that aims to make the use of a Cluster of Povray renderers easy. 

DPovray is built on top of the [BrB](http://www.tricksonrails.com/2010/04/introducing-brb-extremely-fast-interface-for-doing-distributed-ruby 'BrB') library and there is a strong focus on speed, usability, ease of deployment and performance. 
	
This is a project for course Conception of Distributed Systems and Cooperative systems. Prof. Vincent Englebert and Prof. Fabian Gilson are the teachers.  	

Components
===
The system is composed of 4 components:
	
* Web User Interface: The user, a professional 3D artist for example, use a Website to upload a .pov file. In return, he receives the rendered image.
	
* Project Server : The PS manages the cluster of workers. It will receive incoming .pov files from the Web User Interface and will apply divide and conquer strategy to render the scene using the whole cluster of workers.
	
* Worker: Every node of the Cluster is a Worker and its mission is to render .pov scenes and return an image to Project Server.
	                         
* Renderer: The renderer we are going to use is [Povray](http://www.povray.org 'Povray'). 
		   
How it works
===
Each Worker will broadcast its service, stating is ability to accept incoming Job requests. The Project Server will be listening for this broadcast and will act on it. Each time the PS found a new worker it will add it to the list 'Worker List'.
	
The Project Server will be listening for incoming Job Request from the Web User Interface. When the PS receives a .pov file it will create a new project. This new project will be added to a list 'Project List'.
	
A Project contains the information necessary to identify a .pov file, and special arguments for povray.
		
The Project Server will iterate sequentially over the list of Project and will apply a divide and conquer algorithm.
		
Every scene has a width and height. The idea is to divide the rendering in many areas. That way we can distribute the calculations for each area in a different worker. 
		
The Project Server will then send to each worker in the Worker List information to render an specific subarea of the scene.
		         
The worker in turn will send back an partial image. When the server has all the partial images it will apply a merging algorithm to form the final image. Finally this image will be sent to the Web User Interface.
		                            
		
Reliability
===
We must ensure that a failing worker doesn't make the final rendering of a scene fail. For that reason, the Project Server will check the status of Workers registered in the Worker List.
	
* If a worker is not available and it didn't had a Job assigned, then that worker is simply removed from the Worker List.
	
* If a worker is not available and it had a Job assigned, then that Job will be assigned to a different Worker and the failing Worker will be removed from the list.
	
* If a worker is available, then nothing is done.

With that algorithm we can ensure that failing Workers doesn't make the system fail in performing a render.                

Testing
===
Ensuring that the system works as expected will be done at 3 levels. We will follow [BBD](http://en.wikipedia.org/wiki/Behavior_Driven_Development 'BDD').
	
* First level will be the use of [Cucumber](http://www.cukes.info 'Cucumber') for application hight view specification and testing.                             
	                                                            
* Second level will be the use of [RSpec](http://rspec.info/ 'RSpec') for application low level specification and testing.
	
* Third level will be performing argument data validation in every method.
	
With all of these tools and development process we expect to build a very robust system.    

To run tests go to command line and move to the dpovray folder. Get inside one of the components, for example 'Worker', and type:

* To run cucumber tests: <tt>cucumber</tt>

* To run Rspec tests: <tt>rspec spec --color --format doc</tt>

Documentation
===
Documentation will be done at two levels.

* In Code documentation: The code will be documented using RDoc, the native ruby documentation tool.

* Formal Documents: Application specification will be formally documented using traditional documents and diagrams. 
	
Project Management
===
Project management will be done using a [Pivotal](http://www.pivotaltracker.com/projects/128982 Pivotal) project.

Deployment 
===
Deployment of DPovray is not implemented yet, but assuming the system has ruby installed the expected process would be:

* gem install dpovray

That's it.

Now to launch each component:

* [Worker] <tt>dpovray worker</tt>
* [Web User Interface] <tt>dpovray web</tt>
* [Project Server] <tt>dpovray manager</tt>     

Optional parameters may be given. For example, port number.
                                             
Getting the sources
===                                                
* git clone git@github.com:Nerian/DPovray.git   
* svn checkout http://svn.github.com/Nerian/DPovray.git

Issues Tracking
===
Found a bug? Suggestion? 

Send a message or use the [issue_tracker](http://github.com/Nerian/DPovray/issues "issuetracker")          

Copyright © 2010 Gonzalo Rodríguez-Baltanás Díaz 

                                