/* ----------------------------- agent config class ----------------------- */
class read_agent_config extends uvm_object;
    `uvm_object_utils(read_agent_config) 

    virtual async_fifo_interface vif;  
    
    uvm_active_passive_enum is_active = UVM_ACTIVE; 
    
    static int mon_rcvd_xtn_cnt = 0;  
    static int drv_data_sent_cnt = 0;
    
    extern function new(string name = "read_agent_config");
endclass : read_agent_config

function read_agent_config::new(string name = "read_agent_config");
    super.new(name);
endfunction : new
