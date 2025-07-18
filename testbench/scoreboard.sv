class scoreboard extends uvm_scoreboard;

           `uvm_component_utils(scoreboard)

           uvm_analysis_imp #(transaction, scoreboard)   recv;
           bit [31:0] stored_data [bit [31:0]];

           function new(string name = "scoreboard", uvm_component parent = null);
                  super.new(name, parent);   
                  recv = new("recv", this);
           endfunction 

           virtual function void write(transaction tr);

                  if (tr.PWRITE) 
                  begin
                       stored_data[tr.PADDR] = tr.PWDATA;

                       `uvm_info("SCO", $sformatf(" STORED - ADDR: %0d  DATA: %0d", 
                                                 tr.PADDR, tr.PWDATA), UVM_MEDIUM)
                  end

                  else 
                  begin
                       if (!stored_data.exists(tr.PADDR)) 
                       begin
                            stored_data[tr.PADDR] = 32'h0;   // Initialize if not exists
                       end
                       
                       if (stored_data[tr.PADDR] == tr.PRDATA) 
                       begin
                            `uvm_info("SCO", $sformatf(" PASS - ADDR: %0d  EXP: %0d  ACT: %0d", 
                                                      tr.PADDR, stored_data[tr.PADDR], tr.PRDATA), UVM_MEDIUM)
                       end
                       else 
                       begin
                            `uvm_error("SCO", $sformatf(" FAIL! ADDR: %0d  EXP: %0d  ACT: %0d", 
                                                       tr.PADDR, stored_data[tr.PADDR], tr.PRDATA))
                       end
                  end

           endfunction

endclass
