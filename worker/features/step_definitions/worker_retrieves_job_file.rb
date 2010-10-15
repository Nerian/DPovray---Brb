When /^I receive a job$/ do
  Worker::Worker.add_job("-w320 -h120","povray.pov")
end

Then /^I should see "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
