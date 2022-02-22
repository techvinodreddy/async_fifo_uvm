class write_driver extends uvm_driver #(write_packet);
  `uvm_component_utils(write_driver)
  virtual async_fifo_interface.WR_DRV_MP vif;
  write_agent_config wr_agt_cfg;

  extern function new(string name = "write_driver", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
  extern task send_to_dut(write_packet wr_pkt);
  extern task run_phase(uvm_phase phase);

endclass : write_driver

function write_driver::new(string name = "write_driver", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void write_driver::build_phase(uvm_phase phase);
  if(!uvm_config_db #(write_agent_config)::get(this,"","write_agent_config",wr_agt_cfg))
    `uvm_fatal("CONFIG","cannot get() wr_agt_cfg from uvm_config_db. Have you set it?")

  super.build_phase(phase);
endfunction : build_phase

function void write_driver::connect_phase(uvm_phase phase);
  vif = wr_agt_cfg.vif;
endfunction : connect_phase

task write_driver::send_to_dut(write_packet wr_pkt);
  @(vif.wr_drv_cb);
  vif.wr_drv_cb.wrstn <= wr_pkt.wrstn;
  vif.wr_drv_cb.winc  <= wr_pkt.winc;
  vif.wr_drv_cb.wdata  <= wr_pkt.wdata;

  $display("data sent to duv from write driver");

  seq_item_port.put_response(wr_pkt);
endtask

task write_driver::run_phase(uvm_phase phase);
  forever 
    begin
      seq_item_port.get_next_item(req);
      send_to_dut(req);
      seq_item_port.item_done;
    end
endtask