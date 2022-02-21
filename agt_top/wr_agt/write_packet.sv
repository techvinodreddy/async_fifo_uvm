
/* ---------------------------- write_packet [Transaction] ---------------------------------- */
class write_packet extends uvm_sequence_item;
    `uvm_object_utils(write_packet)

    rand bit [31:0] wdata;
    rand bit        winc;
    bit             wrstn;
    bit             wfull;
    bit             awfull;
    bit             rempty;
    bit             arempty;

    extern function new(string name = "write_packet");
    extern function void do_print(uvm_printer printer);
endclass : write_packet

function write_packet::new(string name = "write_packet");
    super.new(name);
endfunction : new

function void write_packet::do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("wdata",    this.wdata,     32, UVM_DEC);
    printer.print_field("winc",     this.winc,      1,  UVM_DEC);
    printer.print_field("wrstn",    this.wrstn,     1,  UVM_DEC);
    printer.print_field("wfull",    this.wfull,     1,  UVM_DEC);
    printer.print_field("awfull",   this.awfull,    1,  UVM_DEC);
    printer.print_field("rempty",   this.rempty,    1,  UVM_DEC);
    printer.print_field("arempty",  this.arempty,   1,  UVM_DEC);

endfunction : do_print