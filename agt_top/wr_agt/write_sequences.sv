class write_base_sequence extends uvm_sequence #(write_packet);
  `uvm_object_utils(write_base_sequence) 
  extern function new(string name = "write_base_sequence");
endclass : write_base_sequence

function write_base_sequence::new(string name = "write_base_sequence");
  super.new(name);
endfunction : new