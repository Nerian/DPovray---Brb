require 'spec_helper'

module Worker
  describe Worker do
    describe "#add_job" do   
      let(:output) {double('output')}  
      let(:worker) {Worker.new(output)}
      it "sends a info message" do                
        output.should_receive(:puts).with('Received a new Job')                     
        worker.add_job("-w320 -h120", "povray.pov")        
      end            
    end    
  end
end