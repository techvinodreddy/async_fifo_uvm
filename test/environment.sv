class environment extends uvm_env;
  `uvm_component_utils(environment)

  environment_config env_cfg;
  agent_top agt_top;
  virtual_sequencer v_seqr;
  scoreboard sb;

  extern function new(string name = "environment", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass : environment

function environment::new(string name = "environment", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void environment::build_phase(uvm_phase phase);
  if(!uvm_config_db #(environment_config)::get(this,"","environment_config",env_cfg))
    `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);

  if(env_cfg.has_agt_top)
    agt_top = agent_top::type_id::create("agt_top",this);

  if(env_cfg.has_virtual_sequencer)
    v_seqr = virtual_sequencer::type_id::create("v_seqr",this);

  if(env_cfg.has_scoreboard)
    sb = scoreboard::type_id::create("sb",this);

endfunction : build_phase

function void environment::connect_phase(uvm_phase phase);
  super.connect_phase(phase);

  if(env_cfg.has_virtual_sequencer)
  begin
    if(env_cfg.has_agt_top)
    begin
      if(env_cfg.has_wr_agt)
	      v_seqr.wr_seqr = agt_top.wr_agt.wr_seqr;

      if(env_cfg.has_rd_agt)
	      v_seqr.rd_seqr = agt_top.rd_agt.rd_seqr;
    end
  end

  if(env_cfg.has_scoreboard)
  begin
    if(env_cfg.has_agt_top)
    begin
      if(env_cfg.has_wr_agt)
        agt_top.wr_agt.wr_mon.write_monitor_analysis_port.connect(sb.wr_fifo.analysis_export);

      if(env_cfg.has_rd_agt)
        agt_top.rd_agt.rd_mon.read_monitor_analysis_port.connect(sb.rd_fifo.analysis_export);
    end
  end

endfunction : connect_phase
