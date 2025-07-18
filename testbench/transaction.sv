class transaction extends uvm_sequence_item;

           `uvm_object_utils(transaction)
    
           rand bit         PWRITE;
           rand bit [31:0]  PADDR;
           rand bit [31:0]  PWDATA;
                bit [31:0]  PRDATA;
    
           constraint valid {
                              PADDR inside {4};
                            }

           function new(input string name = "transaction");
                  super.new(name);  
           endfunction

endclass
