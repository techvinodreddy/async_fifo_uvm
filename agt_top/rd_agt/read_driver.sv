class read_driver extends uvm_driver #(read_packet);
  `uvm_component_utils(read_driver)
  virtual async_fifo_interface.RD_DRV_MP vif;
  read_agent_config rd_agt_cfg;

  extern function new(string name = "read_driver", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task send_to_dut(read_packet rd_pkt);
  extern task run_phase(uvm_phase phase);

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

task read_driver::send_to_dut(read_packet rd_pkt);
  @(vif.rd_drv_cb);
  vif.rd_drv_cb.rrstn <= rd_pkt.rrstn;
  vif.rd_drv_cb.rinc  <= rd_pkt.rinc;

  $display("data sent to duv from read driver");

  seq_item_port.put_response(rd_pkt);
endtask

task read_driver::run_phase(uvm_phase phase);
  forever 
    begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done;
    end
endtask