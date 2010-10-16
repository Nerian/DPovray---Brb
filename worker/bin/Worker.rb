#!/usr/bin/env ruby
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__) 
require 'worker'                        


worker = Worker::Worker.new(STDOUT) 

options = "-w320 -h120"
file_name = "povray.pov"        

worker.add_job(options,file_name)