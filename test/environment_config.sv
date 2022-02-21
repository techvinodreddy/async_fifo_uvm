class environment_config extends uvm_object;
    `uvm_object_utils(environment_config)

    bit has_functional_coverage = 0;
    bit has_scoreboard = 1;
    bit has_agt_top = 1;
    bit has_wr_agt = 1;
    bit has_rd_agt = 1;
    bit has_virtual_sequencer = 1;

    write_agent_config wr_agt_cfg;
    read_agent_config  rd_agt_cfg;
    
    extern function new(string name = "environment_config");
endclass : environment_config

function environment_config::new(string name = "environment_config");
    super.new(name);
endfunction : new
