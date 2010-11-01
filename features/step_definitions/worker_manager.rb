Given /^I can use (\d+) number of cores$/ do |number_of_cores|
  @worker_manager = WorkerManager::WorkerManager.new(number_of_cores)
end

When /^I start working on those jobs$/ do  
end

Then /^I should split the job in many sub-jobs$/ do
  @worker_manager.split_job()
end

Then /^I should create workers and assign them the jobs$/ do
  @worker_manager.render_scene()
end

Then /^I should receive (\d+) Partial Images$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end 

Given /^I had received job id "([^"]*)" sc "([^"]*)" ec "([^"]*)"$/ do |id, startingCol, endingCol|
  @worker_manager.addJob(Job::Job.new(id, startingCol, endingCol))
end
              
Then /^I should see the division results as "([^"]*)"$/ do |arg1|
  @worker_manager.subjobs.to_s.should == arg1
end