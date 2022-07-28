// Module Name:     sram
// Author:          WuHan University  clong
// Date Created:    1-June-2020

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
`include "tb_defines.sv"
interface apb_interface(input PCLK);   
    logic                   PRESETn;    // Active low reset
    logic                   PSEL;       // Select signal
    logic                   PENABLE;    // Enable signal
    logic                   PWRITE;     // Write Strobe
    logic [`ADDR_WIDTH-1:0] PADDR;      // Addr 
    logic [`DATA_WIDTH-1:0] PWDATA;     // Write Data
    logic [`DATA_WIDTH-1:0] PRDATA;     // Read Data
    logic                   PREADY;     // Slave Ready Signal
    logic                   PSLVERR;    // Slave Error Response
    
    // clocking block declarations
    clocking cb @(posedge PCLK);
        default input #1ns output #1ns;  // default delay skew
        output  PSEL;
        output  PENABLE;
        output  PWRITE;
        output  PADDR;
        output  PWDATA;
        input   PREADY;
        input   PRDATA;
        input   PSLVERR;
    endclocking: cb
    
    // modport declarations
    modport dut(output PRESETn, clocking cb);
    
    ///////////////////////////////////// property check assertions ////////////////////////////////////
    // apb_read transfer seq check
    property apb_read_seq_prop;
        @(posedge PCLK) disable iff(!PRESETn)
        PSEL && !PWRITE && PADDR!='bx |=> PENABLE ##[1:$] PREADY ##1 !PENABLE |-> !PSEL;
    endproperty    
    
    // apb_write transfer seq check
    property apb_write_seq_prop;
        @(posedge PCLK) disable iff(!PRESETn)
        PSEL && PWRITE && PADDR!='bx |=> PENABLE ##[1:$] PREADY ##1 !PENABLE |-> !PSEL;
    endproperty
    
    // property check assertions
    assert property(apb_read_seq_prop); 
    assert property(apb_write_seq_prop);
    
    ///////////////////////////////////// Interface Tasks /////////////////////////////////////////////
    // interface reset task
    task reset_intf();
        PRESETn = 0;  // trigger Reset
        PSEL = 0;
        PENABLE = 0;
        PWRITE = 0;
        repeat(2) 
            @(posedge PCLK);
        PRESETn = 1;  // back to normal operation
        @(posedge PCLK);
    endtask
endinterface : apb_interface