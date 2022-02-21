`include "async_fifo_interface.sv"
`include "test_pkg.sv"

`timescale 1ns/10ps
module top;
  import test_pkg::*;
  import uvm_pkg::*;

  bit wclk,rclk;
  always #10 wclk = !wclk;
  always #20 rclk = !rclk;

  async_fifo_interface in1(wclk, rclk);

  initial
  begin
    uvm_config_db #(virtual async_fifo_interface)::set(null,"*","vif",in1);

    run_test("base_test");
  end

endmodule
