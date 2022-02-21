class agent_top extends uvm_agent;
  `uvm_component_utils(agent_top)

  environment_config env_cfg;
  write_agent wr_agt;
  read_agent rd_agt;

  extern function new(string name = "agent_top", uvm_component parent);
  extern function void build_phase(uvm_phase phase);

endclass : agent_top

function agent_top::new(string name = "agent_top", uvm_component parent);
  super.new(name,parent);
endfunction : new

function void agent_top::build_phase(uvm_phase phase);
  if(!uvm_config_db #(environment_config)::get(this,"","environment_config",env_cfg))
    `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set it?")
  super.build_phase(phase);

  if(env_cfg.has_agt_top)
  begin
    if(env_cfg.has_wr_agt)
    begin
      uvm_config_db #(write_agent_config)::set(this,"wr_agt*","write_agent_config",env_cfg.wr_agt_cfg);
      wr_agt = write_agent::type_id::create("wr_agt",this);
    end
    if(env_cfg.has_rd_agt)
    begin
      uvm_config_db #(read_agent_config)::set(this,"rd_agt*","read_agent_config",env_cfg.rd_agt_cfg);
      rd_agt = read_agent::type_id::create("rd_agt",this);
    end
    
  end
endfunction : build_phase