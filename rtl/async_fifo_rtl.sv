// --------------------------------------------------------------------
//  Author   : Vinod Reddy
//  version  : 0.1
//  Purpose  : asynchoronuos fifo in SystemVerilog
// --------------------------------------------------------------------

module asyn_fifo
#( parameter ASIZE = 4,           
   parameter DSIZE = 8,
   parameter FALLTHROUGH = "TRUE" // First word fall-through
)
(
  input  logic             wclk, rclk,
  input  logic             wrst_n, rrst_n,
  input  logic             winc, rinc,
  input  logic [DSIZE-1:0] wdata,
  output logic             wfull, awfull,
  output logic [DSIZE-1:0] rdata,
  output logic             rempty, arempty
);

logic [ASIZE-1:0] waddr, raddr;
logic [ASIZE:0]   wptr, rptr, rptr_wq2, wptr_rq2;

sync_w2r #(ASIZE) sync_w2r (.*); // send write pointer to read domain, synchronizer

sync_r2w #(ASIZE) sync_r2w (.*); // send read pointer to write domain, synchronizer

fifo_memory #(ASIZE, DSIZE, FALLTHROUGH) fifo_memory (.*, .wclken(winc), .rclken(rinc)); // fifo memory

rptr_empty #(ASIZE) rptr_empty (.*); // read pointer empty

wptr_full #(ASIZE) wptr_full (.*); // write pointer full

endmodule

// --------------------------------------------------------------------
//  Purpose  : A synchronizer for passing the write pointer values from  
//             write domain to the read domain
// --------------------------------------------------------------------

module sync_w2r
#( parameter ASIZE = 4)
(
  input  logic           rclk,
  input  logic           rrst_n,
  input  logic [ASIZE:0] wptr,
  output logic [ASIZE:0] wptr_rq2
);

logic [ASIZE:0] rwptr_wq1;

always_ff @(posedge rclk or negedge rrst_n)
  begin
    if(!rrst_n) {wptr_rq2, rwptr_wq1} <= 0;
    else {wptr_rq2, rwptr_wq1} <= {rwptr_wq1, wptr};
  end
endmodule

// --------------------------------------------------------------------
//  Purpose  : A synchronizer for passing the read pointer values from  
//             read domain to the write domain
// --------------------------------------------------------------------

module sync_r2w
  #( parameter ASIZE = 4)
  (
    input  logic           wclk,
    input  logic           wrst_n,
    input  logic [ASIZE:0] rptr,
    output logic [ASIZE:0] rptr_wq2 // read pointer to write side
  );

  logic [ASIZE:0] rptr_wq1;

  always_ff @(posedge wclk or negedge wrst_n)
    begin
      if(!wrst_n) {rptr_wq2, rptr_wq1} <= 0;
      else {rptr_wq2, rptr_wq1} <= {rptr_wq1, rptr};
    end
endmodule

// --------------------------------------------------------------------
//  Author   : Vinod Reddy
//  version  : 0.1
//  Purpose  : For finding the write pointer full (full and almost-full)
// --------------------------------------------------------------------

module wptr_full
  #( parameter ASIZE = 4)
  (
    input  logic             wclk,
    input  logic             wrst_n,
    input  logic             winc,
    input  logic [ASIZE:0]   rptr_wq2,
    output logic             wfull,
    output logic             awfull,
    output logic [ASIZE:0]   wptr,
    output logic [ASIZE-1:0] waddr 
  );

  logic [ASIZE:0] wbin;
  logic [ASIZE:0] wgraynext, wbinnext, wgraynext1;
  logic           awfull_val, wfull_val;

  // for memory addr binary is used
  assign waddr      = wbin[ASIZE-1:0];
  assign wbinnext   = (winc & ~wfull) + wbin;

  // converting binary to gray
  assign wgraynext  = (wbinnext >> 1) ^ wbinnext;
  assign wgraynext1 = (wbinnext+1'b1 >> 1) ^ (wbinnext+1'b1);

  // checking pointer position and if match then full and almost-full is asserted
  assign wfull_val  = (wgraynext ==  {~rptr_wq2[ASIZE:ASIZE-1], rptr_wq2[ASIZE-2:0]});
  assign awfull_val = (wgraynext1 == {~rptr_wq2[ASIZE:ASIZE-1], rptr_wq2[ASIZE-2:0]});

  // pointer
  always_ff @(posedge wclk or negedge wrst_n)
    begin
      if(!wrst_n) {wbin, wptr} <= 0;
      else {wbin, wptr} <= {wbinnext, wgraynext};
    end

  // write full
  always_ff @(posedge wclk or negedge wrst_n)
    begin
      if(!wrst_n) {wfull, awfull} <= 0;
      else {wfull, awfull} <= {wfull_val, awfull_val};
    end

endmodule

// --------------------------------------------------------------------
//  Purpose  : For finding the read pointer empty (empty and almost-empty)
// --------------------------------------------------------------------

module rptr_empty
  #( parameter ASIZE = 4)
  (
    input  logic             rclk,
    input  logic             rrst_n,
    input  logic             rinc,
    input  logic [ASIZE:0]   wptr_rq2,
    output logic             rempty,
    output logic             arempty,
    output logic [ASIZE:0]   rptr,
    output logic [ASIZE-1:0] raddr
  );

  logic [ASIZE:0] rbin;
  logic [ASIZE:0] rgraynext, rbinnext, rgraynext1;
  logic           arempty_val, rempty_val;

  assign raddr      = rbin[ASIZE-1:0];
  assign rbinnext   = (rinc & ~rempty) + rbin;

  // converting binary to gray
  assign rgraynext  = (rbinnext >> 1) ^ rbinnext;
  assign rgraynext1 = (rbinnext+1'b1 >> 1) ^ (rbinnext+1'b1);

  // checking pointer position and if match then empty and almost-empty is asserted
  assign rempty_val  = (rgraynext == wptr_rq2);
  assign arempty_val = (rgraynext1 == wptr_rq2);

  // pointer
  always_ff @(posedge rclk or negedge rrst_n)
    begin
      if(!rrst_n) {rbin, rptr} <= 0;
      else {rbin, rptr} <= {rbinnext, rgraynext};
    end

  // read empty
  always_ff @(posedge rclk or negedge rrst_n)
    begin
      if(!rrst_n) {rempty, arempty} <= 0;
      else {rempty, arempty} <= {rempty_val, arempty_val};
    end

endmodule

// --------------------------------------------------------------------
//  Author   : Vinod Reddy
//  version  : 0.1
//  Purpose  : fifo memory
// --------------------------------------------------------------------

module fifo_memory
  #( parameter ASIZE = 4,           
     parameter DSIZE = 32,
     parameter FALLTHROUGH = "TRUE" // First word fall-through
  )
  (
    input  logic             wclk, rclk,
    input  logic             wclken, rclken,
    input  logic             wfull,
    input  logic [ASIZE-1:0] waddr, raddr,
    input  logic [DSIZE-1:0] wdata,
    output logic [DSIZE-1:0] rdata
  );

  localparam DEPTH = 1<<ASIZE;

  logic [DSIZE-1:0] mem [DEPTH-1:0];
  logic [DSIZE-1:0] rdata_reg;

  // write into memory when write-clk-enable and write full is low 
  always_ff @(posedge wclk) 
    if(wclken && !wfull) mem[waddr] <= wdata;
    else mem[waddr] <= mem[waddr];

  // reading from memory
  generate
    if(FALLTHROUGH == "TRUE") always_comb rdata = mem[raddr];
    else
      begin
        always_ff @(posedge rclk)
          begin
            if(rclken) rdata_reg <= mem[raddr];
            else rdata_reg <= rdata_reg; 
          end
        always_comb rdata = rdata_reg;
      end
  endgenerate

endmodule