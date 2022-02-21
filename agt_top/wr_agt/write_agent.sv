class write_agent extends uvm_agent;
  `uvm_component_utils(write_agent)

  write_agent_config wr_agt_cfg;
  write_driver wr_drv;
  write_monitor wr_mon;
  write_sequencer wr_seqr;

  extern function new(string name = "write_agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : write_agent

function write_agent::new(string name = "write_agent", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void write_agent::build_phase(uvm_phase phase);
  if(!uvm_config_db #(write_agent_config)::get(this,"","write_agent_config",wr_agt_cfg))
    `uvm_fatal("CONFIG","cannot get() wr_agt_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);
  
  wr_mon = write_monitor::type_id::create("wr_mon",this);

  if(wr_agt_cfg.is_active==UVM_ACTIVE)
  begin
    wr_drv = write_driver::type_id::create("wr_drv",this);
    wr_seqr = write_sequencer::type_id::create("wr_seqr",this);
  end
endfunction : build_phase

function void write_agent::connect_phase(uvm_phase phase);
  if(wr_agt_cfg.is_active==UVM_ACTIVE)
    wr_drv.seq_item_port.connect(wr_seqr.seq_item_export);
endfunction : connect_phase
