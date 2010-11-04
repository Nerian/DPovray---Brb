Feature: WorkerManager use a worker to render a scene
	In order to be able to render a scene
	As a Worker Manager
	I want to be able to create many workers and assign them jobs.


Scenario Outline: Worker Manager split the job in many pieces among workers. 
	Given I can use <cores> number of cores
	And I had received job <job>   
	When I start working on those jobs
	Then I should split the job in many sub-jobs
	And I should see the division results as <job_division_result>
	And I should create workers and assign them the jobs
	And I should receive <number_workers> Partial Images

	Examples:
		| cores | job | job_division_result | number_workers |
		| 1 | id "p1.pt1" sc "0%" ec "100%" | "[id:p1.pt1 starting_column:0 ending_column:50, id:p1.pt1 starting_column:50 ending_column:100]" | 2 |
		| 2 | id "p1.pt1" sc "0%" ec "100%" | "[id:p1.pt1 starting_column:0 ending_column:25, id:p1.pt1 starting_column:25 ending_column:50, id:p1.pt1 starting_column:50 ending_column:75, id:p1.pt1 starting_column:75 ending_column:100]" | 4 |
		| 1 | id "p1.pt1" sc "0%" ec "50%"  | "[id:p1.pt1 starting_column:0 ending_column:25, id:p1.pt1 starting_column:25 ending_column:50]" | 2 |
		| 1 | id "p1.pt1" sc "0%" ec "25%"  | "[id:p1.pt1 starting_column:0 ending_column:12, id:p1.pt1 starting_column:12 ending_column:25]" | 2 |









