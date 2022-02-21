class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)

  uvm_tlm_analysis_fifo #(write_packet) wr_fifo;
  uvm_tlm_analysis_fifo #(read_packet) rd_fifo;
  environment_config env_cfg;

  extern function new(string name = "scoreboard", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
    
endclass : scoreboard

function scoreboard::new(string name = "scoreboard", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void scoreboard::build_phase(uvm_phase phase);
  if(!uvm_config_db #(environment_config)::get(this,"","environment_config",env_cfg))
    `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);
  
  if(env_cfg.has_wr_agt)
    wr_fifo = new("wr_fifo",this);
  
  if(env_cfg.has_rd_agt)
    rd_fifo = new("rd_fifo",this);

endfunction : build_phase