// Module Name:     sram
// Author:          WuHan University  clong
// Date Created:    1-June-2020

class apb_err_wr_sequence extends apb_base_sequence;
    `uvm_object_utils(apb_err_wr_sequence)
    
    bit rand_addr;  // flag for enabling randomized address
    bit rand_data;  // flag for enabling randomized data
    
    // constructor function
    function new(string name="apb_err_wr_sequence");
        super.new(name);
    endfunction: new
    
    // body
    virtual task body();
        // construct seq item
        item = apb_seq_item::type_id::create("item");
        
        start_item(item);
            if(rand_data) begin  // random data
                if(rand_addr) begin  // random address
                    // turn off default constraints for address
                    item.addr_constr.constraint_mode(0);
                    assert(item.randomize() with {item.op_type == WRITE;
                                                  item.ADDR > `APB_SRAM_SIZE;
                                });
                end
                else begin  // directed address
                    // turn off default constraints for address
                    item.addr_constr.constraint_mode(0);
                    assert(item.randomize() with {item.op_type == WRITE;
                                                  item.ADDR == local::addr;
                                });
                end
            end
            else begin  // directed data
                if(rand_addr) begin  // random address
                    // turn off default constraints for address
                    item.addr_constr.constraint_mode(0);
                    assert(item.randomize() with {item.op_type == WRITE;
                                                  item.ADDR > `APB_SRAM_SIZE;
                                                  item.DATA == local::data;
                                });
                end
                else begin  // directed address
                    // turn off default constraints for address
                    item.addr_constr.constraint_mode(0);
                    assert(item.randomize() with {item.op_type == WRITE;
                                                  item.ADDR == local::addr;
                                                  item.DATA == local::data;
                                });
                end
            end
        finish_item(item);    
    endtask: body
endclass: apb_err_wr_sequence