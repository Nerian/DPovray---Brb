# Author:: Gonzalo Rodríguez-Baltanás Díaz  
# Licence:: See Licence.rdoc

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
  @worker = Worker::Worker.new(output)  
  job = Job::Job.new('project_name', '-w50 -h50', 'povray.pov', 'partial_image_file_name')                           
  @worker.add_job(job.serialize())
end            

When /^I ask for a \.pov file$/ do
  @worker.retrieve_pov_file_from_server()
end     

When /^I run povray$/ do
  @worker.povray_start_render()
end

When /^I send the partial image to project server$/ do
  @worker.send_rendered_image_to_job_requester()
end
      
Then /^I should see "([^"]*)"$/ do |message|  
  output.messages.should include(message)
end