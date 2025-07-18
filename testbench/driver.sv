class driver extends uvm_driver #(transaction);

           `uvm_component_utils(driver)

           virtual apb_interface vif;

           function new(string name = "driver", uvm_component parent = null);
                  super.new(name, parent);  
           endfunction

           virtual function void build_phase(uvm_phase phase);
                  super.build_phase(phase);

                  if (!uvm_config_db #(virtual apb_interface)::get(this, "", "vif", vif)) 
                  begin
                       `uvm_fatal("DRV", "Unable to access APB interface")
                  end
           endfunction

           virtual task reset_phase(uvm_phase phase);

                  vif.PSEL    <= 1'b0;
                  vif.PENABLE <= 1'b0;
                  vif.PWRITE  <= 1'b0;
                  vif.PADDR   <= 32'h0;
                  vif.PWDATA  <= 32'h0;

           endtask

           virtual task write(transaction tr);

                  @(posedge vif.PCLK);
                        vif.PSEL    <= 1'b1;
                        vif.PWRITE  <= 1'b1;
                        vif.PADDR   <= tr.PADDR;
                        vif.PWDATA  <= tr.PWDATA;
        
                  @(posedge vif.PCLK);
                        vif.PENABLE <= 1'b1;
        
                  @(posedge vif.PCLK);
                        vif.PSEL    <= 1'b0;
                        vif.PENABLE <= 1'b0;

                        `uvm_info("DRV", $sformatf(" WRITE - ADDR: %0d  DATA: %0d", 
                                                 tr.PADDR, tr.PWDATA), UVM_MEDIUM)

           endtask

           virtual task read(transaction tr);

                  @(posedge vif.PCLK);
                        vif.PSEL    <= 1'b1;
                        vif.PWRITE  <= 1'b0;
                        vif.PADDR   <= tr.PADDR;
                        vif.PENABLE <= 1'b0;
        
                  @(posedge vif.PCLK);
                        vif.PENABLE <= 1'b1;
        
                  @(posedge vif.PCLK);
                        tr.PRDATA   = vif.PRDATA;
                        vif.PSEL    <= 1'b0;
                        vif.PENABLE <= 1'b0;

                        `uvm_info("DRV", $sformatf(" READ  - ADDR: %0d  DATA: %0d", 
                                                 tr.PADDR, tr.PRDATA), UVM_MEDIUM)

           endtask

           virtual task run_phase(uvm_phase phase);

                  forever 
                  begin
                       transaction tr;
                       seq_item_port.get_next_item(tr);

                       if (tr.PWRITE)
                            write(tr);
                       else
                            read(tr);

                       seq_item_port.item_done();
                  end

           endtask

endclass
