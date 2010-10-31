Given /^I can use (\d+) number of cores$/ do |number_of_cores|
  @worker_manager = WorkerManager::WorkerManager.new(number_of_cores)
end

When /^I start working on those jobs$/ do  
end

Then /^I should split the job in many sub-jobs$/ do
  @worker_manager.split_job()
end

Then /^I should create workers and assign them the jobs$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should receive (\d+) Partial Images$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end 

Given /^I had received job id "([^"]*)" sc "([^"]*)" ec "([^"]*)"$/ do |id, startingCol, endingCol|
  @worker_manager.addJob(Job::Job.new(id, startingCol, endingCol))
end
              
Then /^I should see \{'(\d+)'=>\{'sc'=>(\d+)% , 'ec'=>(\d+)%\}, '(\d+)'=>\{'sc'=>'(\d+)%', 'ec' => '(\d+)%'\}, '(\d+)'=>\{'sc'=>'(\d+)%' , 'ec'=>'(\d+)%'\}, '(\d+)'=>\{'sc'=>'(\d+)%' , 'ec'=>'(\d+)%'\}\}$/ do |arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12|
  pending # express the regexp above with the code you wish you had
end

Then /^I should see \{'(\d+)'=>\{'sc'=>(\d+)% , 'ec'=>(\d+)%\}, '(\d+)'=>\{'sc'=>'(\d+)%', 'ec' => '(\d+)%'\}\}$/ do |arg1, arg2, arg3, arg4, arg5, arg6|
  pending # express the regexp above with the code you wish you had
end