class monitor extends uvm_monitor;

           `uvm_component_utils(monitor)
    
           virtual apb_interface                   vif;
           uvm_analysis_port #(transaction) send;
           transaction                     tr_q[$];

           function new(string name = "monitor", uvm_component parent = null);
                  super.new(name, parent); 
                  send = new("send", this); 
                  `uvm_info("MON", "Monitor created", UVM_LOW)
           endfunction

           virtual function void build_phase(uvm_phase phase);
                  super.build_phase(phase);

                  if (!uvm_config_db #(virtual apb_interface)::get(this, "", "vif", vif)) 
                  begin
                       `uvm_fatal("MON", "Unable to access APB interface")
                  end
           endfunction

           virtual task run_phase(uvm_phase phase);

                  forever 
                  begin
                       @(posedge vif.PCLK);

                       if (vif.PSEL && vif.PENABLE && vif.PRESETn) 
                       begin
                            transaction tr;
                            tr = transaction::type_id::create("tr");

                            tr.PADDR  = vif.PADDR;
                            tr.PWRITE = vif.PWRITE;

                            if (vif.PWRITE) 
                            begin
                                 tr.PWDATA = vif.PWDATA;

                                 `uvm_info("MON", $sformatf("WRITE - ADDR: %0d  DATA: %0d", 
                                                          vif.PADDR, vif.PWDATA), UVM_MEDIUM)
                            end

                            else 
                            begin
                                 tr.PRDATA = vif.PRDATA;

                                 `uvm_info("MON", $sformatf("READ  - ADDR: %0d  DATA: %0d", 
                                                          vif.PADDR, vif.PRDATA), UVM_MEDIUM)
                            end

                            send.write(tr);
                       end
                  end

           endtask

endclass
