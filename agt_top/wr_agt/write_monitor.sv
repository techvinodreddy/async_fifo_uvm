class write_monitor extends uvm_monitor;
  `uvm_component_utils(write_monitor)
  virtual async_fifo_interface.WR_MON_MP vif;
  write_agent_config wr_agt_cfg;
  write_packet wr_pkt;

  uvm_analysis_port #(write_packet) write_monitor_analysis_port;

  extern function new(string name = "write_monitor", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task write_collect_data();
  extern task run_phase(uvm_phase phase);
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

task read_monitor::write_collect_data();
  @(vif.rd_mon_cb);
  wr_pkt.rrstn   = vif.wr_mon_cb.wrstn;
  wr_pkt.rinc    = vif.wr_mon_cb.winc;
  wr_pkt.rdata   = vif.wr_mon_cb.wdata;
  wr_pkt.wfull   = vif.wr_mon_cb.wfull;
  wr_pkt.awfull  = vif.wr_mon_cb.awfull;
  wr_pkt.rempty  = vif.wr_mon_cb.rempty;
  wr_pkt.arempty = vif.wr_mon_cb.arempty;

  `uvm_info(get_type_name(), "read data recevied from duv \n %s", rd_pkt.sprint(), UVM_LOW)
  read_monitor_analysis_port.write(rd_pkt);

endtask : write_collect_data

task read_monitor::run_phase(uvm_phase phase);
  wr_pkt = write_packet::type_id::create("wr_pkt");

  forever
    write_collect_data();
endtask : run_phase