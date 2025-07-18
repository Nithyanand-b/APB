class env extends uvm_env;
    `uvm_component_utils(env)

    agent agt;
    reg_block reg_model;
    adapter adapter_a;
    uvm_reg_predictor #(transaction) predictor_p;
    scoreboard scb;

    function new(input string name = "env", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("ENV", "Environment created", UVM_LOW)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ENV", "Build phase started", UVM_LOW)
        
        // Create components in proper order
        agt = agent::type_id::create("agt", this);
        scb = scoreboard::type_id::create("scb", this);
        
        // Register model must be built before predictor
        reg_model = reg_block::type_id::create("reg_model", this);
        reg_model.build();  // Explicit build call
        
        adapter_a = adapter::type_id::create("adapter_a", this);
        predictor_p = uvm_reg_predictor #(transaction)::type_id::create("predictor_p", this);
        
        `uvm_info("ENV", "Build phase completed", UVM_LOW)
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ENV", "Connect phase started", UVM_LOW)
        
        // Verify all components exist before connecting
        if (agt == null || agt.mon == null || scb == null || 
            reg_model == null || adapter_a == null || predictor_p == null) begin
            `uvm_fatal("ENV", "Null handle detected in connect phase")
        end

        // Make connections
        agt.mon.send.connect(scb.recv);
        agt.mon.send.connect(predictor_p.bus_in);

        // Register model setup
        if (agt.seqr == null) begin
            `uvm_fatal("ENV", "Agent sequencer is null")
        end
        
        reg_model.default_map.set_sequencer(agt.seqr, adapter_a);
        reg_model.default_map.set_base_addr('h0);
        
        predictor_p.map = reg_model.default_map;
        predictor_p.adapter = adapter_a;
        
        `uvm_info("ENV", "Connect phase completed", UVM_LOW)
    endfunction
endclass