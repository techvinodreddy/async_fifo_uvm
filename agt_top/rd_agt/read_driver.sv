class read_driver extends uvm_driver #(read_packet);
  `uvm_component_utils(read_driver)
  virtual async_fifo_interface.RD_DRV_MP vif;
  read_agent_config rd_agt_cfg;

  extern function new(string name = "read_driver", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);

endclass : read_driver

function read_driver::new(string name = "read_driver", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void read_driver::build_phase(uvm_phase phase);
  if(!uvm_config_db #(read_agent_config)::get(this,"","read_agent_config",rd_agt_cfg))
    `uvm_fatal("CONFIG","cannot get() rd_agt_cfg from uvm_config_db. Have you set it?")

  super.build_phase(phase);
endfunction : build_phase

function void read_driver::connect_phase(uvm_phase phase);
  vif = rd_agt_cfg.vif;
endfunction : connect_phase