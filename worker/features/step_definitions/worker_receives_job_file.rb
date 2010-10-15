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
  worker.add_job("-w320 -h120", "povray.pov")
end

Then /^I should see "([^"]*)"$/ do |message|
  output.messages.should include(message)
end
