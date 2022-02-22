class virtual_base_sequences extends uvm_sequence #(uvm_sequence_item);
  `uvm_object_utils(virtual_base_sequences)

  write_sequencer wr_seqr;
  read_sequencer  rd_seqr;
  virtual_sequencer v_seqr;
  environment_config env_cfg;

  extern function new(string name = "virtual_base_sequences");
  extern task body();
endclass : virtual_base_sequences

function virtual_base_sequences::new(string name = "virtual_base_sequences");
  super.new(name);
endfunction : new

task virtual_base_sequences::body();
  if(!uvm_config_db #(environment_config)::get(null,get_full_name(),"environment_config",env_cfg))
    `uvm_fatal("CONFIG","cannot get() env_cfg from uvm_config_db. Have you set it?")

  assert($cast(v_seqr, m_sequencer))

  else
    `uvm_error("BODY", "Erroe in $cast of virtual sequencer")

    if(env_cfg.has_agt_top)
    begin
      if(env_cfg.has_wr_agt)
        wr_seqr = v_seqr.wr_seqr;

      if(env_cfg.has_rd_agt)
        rd_seqr = v_seqr.rd_seqr;  
    end

endtask : body
