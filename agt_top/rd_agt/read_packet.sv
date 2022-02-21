
/* ---------------------------- read_packet [Transaction] ---------------------------------- */
class read_packet extends uvm_sequence_item;
    `uvm_object_utils(read_packet)

    bit      [31:0] rdata;
    rand bit        rinc;
    bit             rrstn;
    bit             wfull;
    bit             awfull;
    bit             rempty;
    bit             arempty;

    extern function new(string name = "read_packet");
    extern function void do_print(uvm_printer printer);
endclass : read_packet

function read_packet::new(string name = "read_packet");
    super.new(name);
endfunction : new

function void read_packet::do_print(uvm_printer printer);
    super.do_print(printer);

    printer.print_field("rdata",    this.rdata,     32, UVM_DEC);
    printer.print_field("rinc",     this.rinc,      1,  UVM_DEC);
    printer.print_field("rrstn",    this.rrstn,     1,  UVM_DEC);
    printer.print_field("wfull",    this.wfull,     1,  UVM_DEC);
    printer.print_field("awfull",   this.awfull,    1,  UVM_DEC);
    printer.print_field("rempty",   this.rempty,    1,  UVM_DEC);
    printer.print_field("arempty",  this.arempty,   1,  UVM_DEC);

endfunction : do_print