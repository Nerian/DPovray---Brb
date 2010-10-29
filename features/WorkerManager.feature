Feature: WorkerManager use a worker to render a scene
	In order to be able to render a scene
	As a Worker Manager
	I want to be able to create many workers and assign them jobs.


Scenario Outline: Worker Manager split the job in many pieces among workers. 
	Given I can use <cores> number of cores
	And I had received job <job>   
	When I start working on those jobs
	Then I should split the job <number_of_jobs> times       
	And I should see <job_division_result>
	And I should create workers and assign them the jobs
	And I should receive <number_workers> Partial Images

	Examples:
		| cores | job | number_of_jobs | job_division_result | number_workers |
		| 1 | id "p1.pt1" sc "0%" ec "100%" | 2 | "{'1'=>{'sc'=>0% , 'ec'=>50%}, '2'=>{'sc'=>'50%', 'ec' => '100%'}}" | 2 |
		| 2 | id "p1.pt1" sc "0%" ec "100%" | 4 | "{'1'=>{'sc'=>0% , 'ec'=>25%}, '2'=>{'sc'=>'25%', 'ec' => '50%'}, '3'=>{'sc'=>'50%' , 'ec'=>'75%'}, '4'=>{'sc'=>'75%' , 'ec'=>'100%'}}" | 4 |
		| 1 | id "p1.pt1" sc "0%" ec "50%" | 2 | "{'1'=>{'sc'=>0% , 'ec'=>25%}, '2'=>{'sc'=>'25%', 'ec' => '50%'}}" | 2 |
		| 1 | id "p1.pt1" sc "0%" ec "25%" | 2 | "{'1'=>{'sc'=>0% , 'ec'=>12%}, '2'=>{'sc'=>'12%', 'ec' => '25%'}}" | 2 |









