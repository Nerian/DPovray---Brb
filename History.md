
n.n.n / 2010-11-04 
==================

  * refactoring of worker_manager. Remove workers_pid
  * Cleanup
  * Fix test. Now the test should fail if the number of completions didnt match the number of jobs. In other words, if any of the workers dont call report, then the test fails
  * Fix problem that caused the app to freeze. The problem was that The workers tried to connect to worker_manager prior the EM machine had time to start. So the connection failed. Add a sleep 2 before the workers.
  * I never gets out of the EM:run.
  * Work in progress
  * work in progress...
  * Re-add Work output shit
  * Make worker_pid list a local attribute
  * WorkerManager fork many workers
  * Asserting for instance_of(job) instead of not nil
  * Doing rspec of worker_manager. Add render scene
  * Implement And I should see the division result...in WorkerManager feature spec
  * Change attr to just attr_reader and set generate_subjobs to private method
  * Add documentation of WorkerManager.rb
  * Change method's name. Division2 => generate_subjobs
  * Fix bug about Job Argument. starting and ending columns can be specified with percentages, but they should be stored as integer. Add test for that
  * I implemented two algorithm for tasks division. Division2 was the good one. I commited (no pun intended) a mistake and removed Division2 instead of Division1.
  * Add rspec tests for the case when Worker_Manager receives a job that is already divided.
  * Change Cucumber WorkerManager specs.
  * Implement the algorithm that divides a job in many jobs.
  * Use 'cover_me' to measure test coverage.
  * Fix cucumber test. It was a job arguments
  * Worker_manager receive jobs. Rspec test done
  * Fix Worker.rb because of the changes in Job arguments
  * Add columns sign rspec test for Job class
  * Refactor arguments in Job. Now it receives startingCol (%) and endingCol(%)
  * Fix typo
  * Cucumber specs of WorkerManager
  * Create worker_manager class and rspec for initialise
  * Write Cucumber feature about the worker manager
  * Add Cleanup method to Worker. This method removes the worker own tmp folder
  * Refactor of Job class. Removed Project name and povray_scene_file_name
  * Refactor. Now rendered image is saved in tmp/@project_id/partial_image
  * Refactor of rspecs Worker
  * Add 'should not be nil' test to Job attribute in Worker spec
  * Name changes
  * Refactor of rspec Worker; Create Folder Structure to use  let(:tmp_folder)
  * Worker has an attribute 'tmp_folder' that is a path to is own tmp folder
  * Update Bundle
  * Add method create_folder_structure. This method creates the /tmp/@id/  folder that will contains all the data for a specific worker
  * Worker have an attribute iD. This atrttibute is used to identify it and in tmp folders
  * Move worker/*  to top level directory
  * spaces
  * The partialImageName dependents on the id of the Job. Now I have to make it save on separate location for each worker
  * Change Error file place from current directory to /tmp/error
  * Use Job::deserialize instead of Marshal. This makes it more easy to read
  * Implement Worker bin example. This doesnt use brb connection yet, but the worker works perfectly. Brb functionality could be added easily. The Project_server object could be retrieved using BrB and passed to the Worker. We can fork the process and have many workers.
  * Add error messages to Project class in method put. This way the user can know if there was an error
  * Use Attr Accessor in worker class
  * Use Attr_accessor for attributes in Job class
  * bump up rspec version
  * Changed README syntax from rdoc to markdown
  * Added link to BrB release blog post
  * Added a section about deployment
  * Restructured the folder hierarchy. Cucumber test now pass.
  * Rspec pass. Cucumber no
  * Now using Bundler to manage Gem dependencies
  * There was a typo
  * Removed licence information from *.feature files. Because it makes ugly the cucumber output
  * refactor of rspec. I move redundant code to 'before' filter
  * Implemented some checks in the project server, method puts. It seems to work pretty well
  * Worker can marshal the image file and call a method on a fake Project Server
  * Cucumber and rspec of feature worker_send_image_file completed. The implementatio is not
  * Added doc/ to ignore file
  * Included Licence and licence information to each file
  * Included Licence and licence information to each file
  * Refactoing. The specs now delete the povray file and scene file from the temp folder
  * Fix README
  * Cucumber specification, RSpec specification and model implementation of worker_start_render feature. I should be making more granular commits, though
  * I changed the 'it' text of rspec test worker_spec.rb to make it more readable
  * README. Added explanation on how to run tests
  * README fix
  * Done rspec of Worker_retrieve_povray_file
  * Implementation of the feature  Worker_retrieve_povray_file
  * Changed name
  * Defined Cucumber feature description for retrieves_a_job_file
  * fix README
  * filename fix
  * refactoring
  * Added messages  'Unmarshalling objects' and 'unmarshalling completed' to worker.add_job() workflow. Done cucumber and rspec test
  * Git ignore and bin directory
  * git ignore and fix
  * README fix
  * Added SVN info to README
  * Readme decoration
  * README fix and added Documentation section
  * Documenting in README
  * Refactoring of worker_spec.rb
  * Rspec definitions for worker
  * Fix file name
  * Steps definitions of worker_receives_job' completed
  * name change
  * Fix of env.rb
  * Created file for Top level requires
  * Restructuring and creation of classes
  * name change
  * I create steps definitions for 'worker_retrieves_file.feature'
  * I set up the Cucumber Folder structure and wrote some features spec
  * First commit fix
  * First commit

n.n.n / 2010-11-04 
==================

  * Cleanup
  * Fix test. Now the test should fail if the number of completions didnt match the number of jobs. In other words, if any of the workers dont call report, then the test fails
  * Fix problem that caused the app to freeze. The problem was that The workers tried to connect to worker_manager prior the EM machine had time to start. So the connection failed. Add a sleep 2 before the workers.
  * I never gets out of the EM:run.
  * Work in progress
  * work in progress...
  * Re-add Work output shit
  * Make worker_pid list a local attribute
  * WorkerManager fork many workers
  * Asserting for instance_of(job) instead of not nil
  * Doing rspec of worker_manager. Add render scene
  * Implement And I should see the division result...in WorkerManager feature spec
  * Change attr to just attr_reader and set generate_subjobs to private method
  * Add documentation of WorkerManager.rb
  * Change method's name. Division2 => generate_subjobs
  * Fix bug about Job Argument. starting and ending columns can be specified with percentages, but they should be stored as integer. Add test for that
  * I implemented two algorithm for tasks division. Division2 was the good one. I commited (no pun intended) a mistake and removed Division2 instead of Division1.
  * Add rspec tests for the case when Worker_Manager receives a job that is already divided.
  * Change Cucumber WorkerManager specs.
  * Implement the algorithm that divides a job in many jobs.
  * Use 'cover_me' to measure test coverage.
  * Fix cucumber test. It was a job arguments
  * Worker_manager receive jobs. Rspec test done
  * Fix Worker.rb because of the changes in Job arguments
  * Add columns sign rspec test for Job class
  * Refactor arguments in Job. Now it receives startingCol (%) and endingCol(%)
  * Fix typo
  * Cucumber specs of WorkerManager
  * Create worker_manager class and rspec for initialise
  * Write Cucumber feature about the worker manager
  * Add Cleanup method to Worker. This method removes the worker own tmp folder
  * Refactor of Job class. Removed Project name and povray_scene_file_name
  * Refactor. Now rendered image is saved in tmp/@project_id/partial_image
  * Refactor of rspecs Worker
  * Add 'should not be nil' test to Job attribute in Worker spec
  * Name changes
  * Refactor of rspec Worker; Create Folder Structure to use  let(:tmp_folder)
  * Worker has an attribute 'tmp_folder' that is a path to is own tmp folder
  * Update Bundle
  * Add method create_folder_structure. This method creates the /tmp/@id/  folder that will contains all the data for a specific worker
  * Worker have an attribute iD. This atrttibute is used to identify it and in tmp folders
  * Move worker/*  to top level directory
  * spaces
  * The partialImageName dependents on the id of the Job. Now I have to make it save on separate location for each worker
  * Change Error file place from current directory to /tmp/error
  * Use Job::deserialize instead of Marshal. This makes it more easy to read
  * Implement Worker bin example. This doesnt use brb connection yet, but the worker works perfectly. Brb functionality could be added easily. The Project_server object could be retrieved using BrB and passed to the Worker. We can fork the process and have many workers.
  * Add error messages to Project class in method put. This way the user can know if there was an error
  * Use Attr Accessor in worker class
  * Use Attr_accessor for attributes in Job class
  * bump up rspec version
  * Changed README syntax from rdoc to markdown
  * Added link to BrB release blog post
  * Added a section about deployment
  * Restructured the folder hierarchy. Cucumber test now pass.
  * Rspec pass. Cucumber no
  * Now using Bundler to manage Gem dependencies
  * There was a typo
  * Removed licence information from *.feature files. Because it makes ugly the cucumber output
  * refactor of rspec. I move redundant code to 'before' filter
  * Implemented some checks in the project server, method puts. It seems to work pretty well
  * Worker can marshal the image file and call a method on a fake Project Server
  * Cucumber and rspec of feature worker_send_image_file completed. The implementatio is not
  * Added doc/ to ignore file
  * Included Licence and licence information to each file
  * Included Licence and licence information to each file
  * Refactoing. The specs now delete the povray file and scene file from the temp folder
  * Fix README
  * Cucumber specification, RSpec specification and model implementation of worker_start_render feature. I should be making more granular commits, though
  * I changed the 'it' text of rspec test worker_spec.rb to make it more readable
  * README. Added explanation on how to run tests
  * README fix
  * Done rspec of Worker_retrieve_povray_file
  * Implementation of the feature  Worker_retrieve_povray_file
  * Changed name
  * Defined Cucumber feature description for retrieves_a_job_file
  * fix README
  * filename fix
  * refactoring
  * Added messages  'Unmarshalling objects' and 'unmarshalling completed' to worker.add_job() workflow. Done cucumber and rspec test
  * Git ignore and bin directory
  * git ignore and fix
  * README fix
  * Added SVN info to README
  * Readme decoration
  * README fix and added Documentation section
  * Documenting in README
  * Refactoring of worker_spec.rb
  * Rspec definitions for worker
  * Fix file name
  * Steps definitions of worker_receives_job' completed
  * name change
  * Fix of env.rb
  * Created file for Top level requires
  * Restructuring and creation of classes
  * name change
  * I create steps definitions for 'worker_retrieves_file.feature'
  * I set up the Cucumber Folder structure and wrote some features spec
  * First commit fix
  * First commit
