class write_monitor extends uvm_monitor;
  `uvm_component_utils(write_monitor)
  virtual async_fifo_interface.WR_MON_MP vif;
  write_agent_config wr_agt_cfg;
  write_packet wr_pkt;

  uvm_analysis_port #(write_packet) write_monitor_analysis_port;

  extern function new(string name = "write_monitor", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : write_monitor

function write_monitor::new(string name = "write_monitor", uvm_component parent);
  super.new(name,parent);
  write_monitor_analysis_port = new("write_monitor_analysis_port",this);
endfunction : new

function void write_monitor::build_phase(uvm_phase phase);
  if(!uvm_config_db #(write_agent_config)::get(this,"","write_agent_config",wr_agt_cfg))
    `uvm_fatal("CONFIG","cannot get() wr_agt_cfg from uvm_config_db. Have you set it?")

  super.build_phase(phase);
endfunction : build_phase

function void write_monitor::connect_phase(uvm_phase phase);
  vif = wr_agt_cfg.vif;
endfunction : connect_phase