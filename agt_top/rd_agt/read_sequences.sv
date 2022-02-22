class read_base_sequence extends uvm_sequence #(read_packet);
  `uvm_object_utils(read_base_sequence) 
  extern function new(string name = "read_base_sequence");
endclass : read_base_sequence

function read_base_sequence::new(string name = "read_base_sequence");
  super.new(name);
endfunction : new

class reset_read_seqs extends read_base_sequence;
  `uvm_object_utils(reset_read_seqs) 
  extern function new(string name = "reset_read_seqs");
  extern task body();
endclass : reset_read_seqs

function reset_read_seqs::new(string name = "reset_read_seqs");
  super.new(name);
endfunction : new

task reset_read_seqs::body();
  req = write_packet::type_id::create("req");

  start_item(req);
  assert(req.randomize() with { rrstn == 1;});
  finish_item(req);
endtask

class ten_read_seqs extends read_base_sequence;
  `uvm_object_utils(ten_read_seqs) 
  extern function new(string name = "ten_read_seqs");
  extern task body();
endclass : ten_read_seqs

function ten_read_seqs::new(string name = "ten_read_seqs");
  super.new(name);
endfunction : new

task ten_read_seqs::body();
  req = write_packet::type_id::create("req");

  repeat(10)
  begin
    if(req.wfull == 0)
    begin
      start_item(req);
      assert(req.randomize() with { rrstn == 1; rinc == 1;});
      finish_item(req);  
    end
  end
  
endtask