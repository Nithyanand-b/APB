class test extends uvm_test;

           `uvm_component_utils(test)
    
           env e;
          //  reg1_wr   r1wr;
          //  reg1_rd   r1rd;
    
           reg2_wr   r2wr;
           reg2_rd   r2rd;
           function new(string name = "test", uvm_component parent = null);
                  super.new(name, parent);
           endfunction
     
           virtual function void build_phase(uvm_phase phase);
                  super.build_phase(phase);

                  e    = env::type_id::create("e", this);
                  // r1wr = reg1_wr::type_id::create("r1wr");
                  // r1rd = reg1_rd::type_id::create("r1rd");

                  r2wr = reg2_wr::type_id::create("r2wr");
                  r2rd = reg2_rd::type_id::create("r2rd");
           endfunction
     
           virtual task run_phase(uvm_phase phase);

                  phase.raise_objection(this);
        
                  // Wait for reset to complete
                  #100;
        
                  // Assign register model
                  // r1wr.reg_model = e.reg_model;
                  // r1rd.reg_model = e.reg_model;

                  r2wr.reg_model = e.reg_model;
                  r2rd.reg_model = e.reg_model;

                  // r3wr.reg_model = e.reg_model;
                  // r3rd.reg_model = e.reg_model;

                  // r4wr.reg_model = e.reg_model;
                  // r4rd.reg_model = e.reg_model;
        
                  `uvm_info("TEST", " Starting sequences", UVM_LOW)

                  // r1wr.start(e.agt.seqr);
                  // r1rd.start(e.agt.seqr);

                  r2wr.start(e.agt.seqr);
                  r2rd.start(e.agt.seqr);

                  // r3wr.start(e.agt.seqr);
                  // r3rd.start(e.agt.seqr);

                  // r4wr.start(e.agt.seqr);
                  // r4rd.start(e.agt.seqr);
        
                  phase.drop_objection(this);

           endtask

endclass
