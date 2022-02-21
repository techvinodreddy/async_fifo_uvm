class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);
    `uvm_component_utils(virtual_sequencer) 

    write_sequencer wr_seqr;
    read_sequencer  rd_seqr;
    environment_config env_cfg;

    extern function new(string name = "virtual_sequencer", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
endclass : virtual_sequencer

function virtual_sequencer::new(string name = "virtual_sequencer", uvm_component parent);
    super.new(name,parent);
endfunction : new

function void virtual_sequencer::build_phase(uvm_phase phase);
    if(!uvm_config_db #(environment_config)::get(this,"","environment_config",env_cfg))
    `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set it?")
    super.build_phase(phase);

endfunction : build_phase
