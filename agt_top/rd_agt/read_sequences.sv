class read_base_sequence extends uvm_sequence #(read_packet);
  `uvm_object_utils(read_base_sequence) 
  extern function new(string name = "read_base_sequence");
endclass : read_base_sequence

function read_base_sequence::new(string name = "read_base_sequence");
  super.new(name);
endfunction : new