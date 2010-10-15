require 'spec_helper'

module Worker
  describe Worker do
    describe "#add_job" do   

      it "sends a info message" do

        output = double('output')   
        
        output.should_receive(:puts).with('Received a new Job')
        #Create a worker
        worker = Worker.new(output)                            

        # We set an expectation, something that should 
        # happen before the end of this example
                                   
        worker.add_job("-w320 -h120", "povray.pov")
      end            
    end    
  end
end