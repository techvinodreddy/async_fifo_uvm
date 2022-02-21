interface async_fifo_interface (input wclk, rclk);
	bit 		wrstn;
	bit 		rrstn;
	bit 		winc;
    bit 		rinc;
	bit 		wfull;
	bit 		awfull;
	bit 		rempty;
	bit 		arempty;
	bit [31:0] 	wdata;
	bit [31:0] 	rdata;

	clocking wr_drv_cb @(posedge wclk);
		default input #1 output #1;
		input  wfull;
		input  awfull;
		input  rempty;
		input  arempty;
		output wrstn;
		output winc;
		output wdata;
	endclocking

	clocking rd_drv_cb @(posedge rclk);
		default input #1 output #1;
		input  wfull;
		input  awfull;
		input  rempty;
		input  arempty;
		output rrstn;
		output rinc;
		output rdata;
	endclocking

	clocking wr_mon_cb @(posedge wclk);
		default input #1 output #1;
		input wfull;
		input awfull;
		input rempty;
		input arempty;
		input wrstn;
		input winc;
		input wdata;
	endclocking

	clocking rd_mon_cb @(posedge rclk);
		default input #1 output #1;
		input wfull;
		input awfull;
		input rempty;
		input arempty;
		input rrstn;
		input rinc;
		input rdata;
	endclocking

	modport WR_DRV_MP (clocking wr_drv_cb);
	modport RD_DRV_MP (clocking rd_drv_cb);
	modport WR_MON_MP (clocking wr_mon_cb);
	modport RD_MON_MP (clocking rd_mon_cb);

endinterface