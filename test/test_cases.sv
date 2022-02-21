class base_test extends uvm_test;
  `uvm_component_utils(base_test)

  environment env;
  environment_config env_cfg;
  write_agent_config wr_agt_cfg;
  read_agent_config  rd_agt_cfg;

  bit has_functional_coverage = 0;
  bit has_scoreboard = 1;
  bit has_agt_top = 1;
  bit has_virtual_sequencer = 1;
  bit has_wr_agt = 1;
  bit has_rd_agt = 1;

  extern function new(string name = "base_test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void config_uart();
  extern function void end_of_elaboration_phase(uvm_phase phase);

endclass : base_test

function base_test::new(string name = "base_test", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void base_test::config_uart;
  if(has_agt_top)
  begin
    if(has_wr_agt)
    begin
      wr_agt_cfg = write_agent_config::type_id::create("wr_agt_cfg");
    
      if(!uvm_config_db #(virtual async_fifo_interface)::get(this,"","vif",wr_agt_cfg.vif))
          `uvm_fatal("VIF CONFIG","cannot get() interface vif from uvm_config_db. Have you set() it?")
        
      env_cfg.wr_agt_cfg = wr_agt_cfg;  
    end
    
    if(has_rd_agt)
    begin
      rd_agt_cfg = read_agent_config::type_id::create("rd_agt_cfg");
    
      if(!uvm_config_db #(virtual async_fifo_interface)::get(this,"","vif",rd_agt_cfg.vif))
          `uvm_fatal("VIF CONFIG","cannot get() interface vif from uvm_config_db. Have you set() it?")
        
      env_cfg.rd_agt_cfg = rd_agt_cfg;  
    end
    
  end
  env_cfg.has_agt_top = has_agt_top;
  env_cfg.has_wr_agt = has_wr_agt;
  env_cfg.has_rd_agt = has_rd_agt;
  env_cfg.has_functional_coverage = has_functional_coverage;
  env_cfg.has_scoreboard = has_scoreboard;
  env_cfg.has_virtual_sequencer = has_virtual_sequencer;
endfunction : config_uart


function void base_test::build_phase(uvm_phase phase);

  env_cfg=environment_config::type_id::create("env_cfg");

  if(has_agt_top)

    config_uart();

    uvm_config_db #(environment_config)::set(this,"*","environment_config",env_cfg);

    super.build_phase(phase);
    env = environment::type_id::create("env",this);

endfunction : build_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
	uvm_top.print_topology;
endfunction : end_of_elaboration_phase