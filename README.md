### Async_FIFO_UVM Topology
***
- There are two agents, write and read agents inside environment.
- In each agent there are monitor, driver and sequencer.
- If agent is configured as passive agent then only monitor is present, or active agent then three of them are present.
- In agent top is the higher level component that has the write and read agents.
- In environment, the scoreboard, virtual sequencer and the agent top are there.
- And finally the test is top level component for the environment.
***

**To print topology run the `testbench.sv` file located in top folder**

**To view code online then click** ***[Async FIFO UVM](https://www.edaplayground.com/x/LzsK)***
``` systemverilog
# KERNEL: UVM_INFO @ 0: reporter [RNTST] Running test base_test...
# KERNEL: UVM_INFO /home/build/vlib1/vlib/uvm-1.2/src/base/uvm_root.svh(583) @ 0: reporter [UVMTOP] UVM testbench topology:
# KERNEL: ------------------------------------------------------------------------------
# KERNEL: Name                                   Type                        Size  Value
# KERNEL: ------------------------------------------------------------------------------
# KERNEL: uvm_test_top                           base_test                   -     @343 
# KERNEL:   env                                  environment                 -     @365 
# KERNEL:     agt_top                            agent_top                   -     @375 
# KERNEL:       rd_agt                           read_agent                  -     @549 
# KERNEL:         rd_drv                         read_driver                 -     @579 
# KERNEL:           rsp_port                     uvm_analysis_port           -     @598 
# KERNEL:           seq_item_port                uvm_seq_item_pull_port      -     @588 
# KERNEL:         rd_mon                         read_monitor                -     @560 
# KERNEL:           read_monitor_analysis_port   uvm_analysis_port           -     @569 
# KERNEL:         rd_seqr                        read_sequencer              -     @608 
# KERNEL:           rsp_export                   uvm_analysis_export         -     @617 
# KERNEL:           seq_item_export              uvm_seq_item_pull_imp       -     @735 
# KERNEL:           arbitration_queue            array                       0     -    
# KERNEL:           lock_queue                   array                       0     -    
# KERNEL:           num_last_reqs                integral                    32    'd1  
# KERNEL:           num_last_rsps                integral                    32    'd1  
# KERNEL:       wr_agt                           write_agent                 -     @536 
# KERNEL:         wr_drv                         write_driver                -     @773 
# KERNEL:           rsp_port                     uvm_analysis_port           -     @792 
# KERNEL:           seq_item_port                uvm_seq_item_pull_port      -     @782 
# KERNEL:         wr_mon                         write_monitor               -     @754 
# KERNEL:           write_monitor_analysis_port  uvm_analysis_port           -     @763 
# KERNEL:         wr_seqr                        write_sequencer             -     @802 
# KERNEL:           rsp_export                   uvm_analysis_export         -     @811 
# KERNEL:           seq_item_export              uvm_seq_item_pull_imp       -     @929 
# KERNEL:           arbitration_queue            array                       0     -    
# KERNEL:           lock_queue                   array                       0     -    
# KERNEL:           num_last_reqs                integral                    32    'd1  
# KERNEL:           num_last_rsps                integral                    32    'd1  
# KERNEL:     sb                                 scoreboard                  -     @521 
# KERNEL:       rd_fifo                          uvm_tlm_analysis_fifo #(T)  -     @1006
# KERNEL:         analysis_export                uvm_analysis_imp            -     @1055
# KERNEL:         get_ap                         uvm_analysis_port           -     @1045
# KERNEL:         get_peek_export                uvm_get_peek_imp            -     @1025
# KERNEL:         put_ap                         uvm_analysis_port           -     @1035
# KERNEL:         put_export                     uvm_put_imp                 -     @1015
# KERNEL:       wr_fifo                          uvm_tlm_analysis_fifo #(T)  -     @947 
# KERNEL:         analysis_export                uvm_analysis_imp            -     @996 
# KERNEL:         get_ap                         uvm_analysis_port           -     @986 
# KERNEL:         get_peek_export                uvm_get_peek_imp            -     @966 
# KERNEL:         put_ap                         uvm_analysis_port           -     @976 
# KERNEL:         put_export                     uvm_put_imp                 -     @956 
# KERNEL:     v_seqr                             virtual_sequencer           -     @384 
# KERNEL:       rsp_export                       uvm_analysis_export         -     @393 
# KERNEL:       seq_item_export                  uvm_seq_item_pull_imp       -     @511 
# KERNEL:       arbitration_queue                array                       0     -    
# KERNEL:       lock_queue                       array                       0     -    
# KERNEL:       num_last_reqs                    integral                    32    'd1  
# KERNEL:       num_last_rsps                    integral                    32    'd1  
# KERNEL: ------------------------------------------------------------------------------

```
