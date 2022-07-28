// Module Name:     sram
// Author:          WuHan University  clong
// Date Created:    1-June-2020

class apb_mstr_sequencer extends uvm_sequencer#(apb_seq_item, apb_seq_item);
    `uvm_component_utils(apb_mstr_sequencer)
    
    // constructor function
    function new(string name="apb_mstr_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction: new 
    
    // build_phase
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase
    
    // connect_phase
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction: connect_phase
    
endclass: apb_mstr_sequencer