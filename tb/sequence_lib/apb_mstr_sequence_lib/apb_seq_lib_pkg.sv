// Module Name:     sram
// Author:          WuHan University  clong
// Date Created:    1-June-2020

    // include and import uvm_pkg
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    
    `include "tb_defines.sv"
    
    // import agent_pkg
    import apb_agent_pkg::*;
            
    // include sequences
    `include "apb_base_sequence.sv"
    `include "apb_rd_sequence.sv"
    `include "apb_wr_sequence.sv"
    `include "apb_err_wr_sequence.sv"
    `include "apb_err_rd_sequence.sv"
endpackage
