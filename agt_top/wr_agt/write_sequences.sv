class write_base_sequence extends uvm_sequence #(write_packet);
  `uvm_object_utils(write_base_sequence) 
  extern function new(string name = "write_base_sequence");
endclass : write_base_sequence

function write_base_sequence::new(string name = "write_base_sequence");
  super.new(name);
endfunction : new

class reset_write_seqs extends write_base_sequence;
  `uvm_object_utils(reset_write_seqs) 
  extern function new(string name = "reset_write_seqs");
  extern task body();
endclass : reset_write_seqs

function reset_write_seqs::new(string name = "reset_write_seqs");
  super.new(name);
endfunction : new

task reset_write_seqs::body();
  req = write_packet::type_id::create("req");

  start_item(req);
  assert(req.randomize() with { wrstn == 1;});
  finish_item(req);
endtask

class ten_write_seqs extends write_base_sequence;
  `uvm_object_utils(ten_write_seqs) 
  extern function new(string name = "ten_write_seqs");
  extern task body();
endclass : ten_write_seqs

function ten_write_seqs::new(string name = "ten_write_seqs");
  super.new(name);
endfunction : new

task ten_write_seqs::body();
  req = write_packet::type_id::create("req");

  repeat(10)
  begin
    if(req.wfull == 0)
    begin
      start_item(req);
      assert(req.randomize() with { wrstn == 1; winc == 1;});
      finish_item(req);  
    end
  end
  
endtask