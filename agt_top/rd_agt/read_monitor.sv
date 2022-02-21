class read_monitor extends uvm_monitor;
  `uvm_component_utils(read_monitor)
  virtual async_fifo_interface.RD_MON_MP vif;
  read_agent_config rd_agt_cfg;
  read_packet rd_pkt;

  uvm_analysis_port #(read_packet) read_monitor_analysis_port;

  extern function new(string name = "read_monitor", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : read_monitor

function read_monitor::new(string name = "read_monitor", uvm_component parent);
  super.new(name,parent);
  read_monitor_analysis_port = new("read_monitor_analysis_port",this);
endfunction : new

function void read_monitor::build_phase(uvm_phase phase);
  if(!uvm_config_db #(read_agent_config)::get(this,"","read_agent_config",rd_agt_cfg))
    `uvm_fatal("CONFIG","cannot get() rd_agt_cfg from uvm_config_db. Have you set it?")

  super.build_phase(phase);
endfunction : build_phase

function void read_monitor::connect_phase(uvm_phase phase);
  vif = rd_agt_cfg.vif;
endfunction : connect_phase