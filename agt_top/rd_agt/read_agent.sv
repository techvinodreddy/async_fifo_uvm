class read_agent extends uvm_agent;
  `uvm_component_utils(read_agent)

  read_agent_config rd_agt_cfg;
  read_driver rd_drv;
  read_monitor rd_mon;
  read_sequencer rd_seqr;

  extern function new(string name = "read_agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : read_agent

function read_agent::new(string name = "read_agent", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void read_agent::build_phase(uvm_phase phase);
  if(!uvm_config_db #(read_agent_config)::get(this,"","read_agent_config",rd_agt_cfg))
    `uvm_fatal("CONFIG","cannot get() rd_agt_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);
  
  rd_mon = read_monitor::type_id::create("rd_mon",this);

  if(rd_agt_cfg.is_active==UVM_ACTIVE)
  begin
    rd_drv = read_driver::type_id::create("rd_drv",this);
    rd_seqr = read_sequencer::type_id::create("rd_seqr",this);
  end
endfunction : build_phase

function void read_agent::connect_phase(uvm_phase phase);
  if(rd_agt_cfg.is_active==UVM_ACTIVE)
    rd_drv.seq_item_port.connect(rd_seqr.seq_item_export);
endfunction : connect_phase
