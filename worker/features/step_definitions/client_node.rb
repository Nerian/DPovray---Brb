class Output
  def messages
    @messages ||= []
  end

  def puts(message)
    messages << message
  end
end

def output
  @output ||= Output.new
end


When /^I receive a job$/ do
  worker = Worker::Worker.new(output)  
  job = Job::Job.new('project_name', '-w320 -h120', 'povray.pov', 'partial_image_file_name')                           
  serialized_job = Marshal.dump(job)
  worker.add_job(job.serialize())
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include(message)
end            

Given /^I have a Job$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I ask for a \.pov file$/ do
  pending # express the regexp above with the code you wish you had
end
