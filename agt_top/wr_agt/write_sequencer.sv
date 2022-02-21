class write_sequencer extends uvm_sequencer #(write_packet);
  `uvm_component_utils(write_sequencer)  
  extern function new(string name = "write_sequencer", uvm_component parent);
endclass : write_sequencer

function write_sequencer::new(string name = "write_sequencer", uvm_component parent);
  super.new(name,parent);
endfunction : new