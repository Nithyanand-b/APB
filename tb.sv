`include "dut/apb_components.sv"

module tb;

           apb_interface vif();

           apb dut (
                .PCLK     (vif.PCLK),
                .PRESETn  (vif.PRESETn),
                .PADDR    (vif.PADDR),
                .PWDATA   (vif.PWDATA),
                .PSEL     (vif.PSEL),
                .PWRITE   (vif.PWRITE),
                .PENABLE  (vif.PENABLE),
                .PRDATA   (vif.PRDATA)
           );

           // Clock generation
           initial 
           begin
                vif.PCLK = 1'b0;
                forever #5 vif.PCLK = ~vif.PCLK;
           end

           // Reset sequence
           initial 
           begin
                vif.PRESETn = 1'b0;
                repeat(5) @(posedge vif.PCLK);
                vif.PRESETn = 1'b1;
           end

           // Start UVM test
           initial 
           begin
                uvm_config_db#(virtual apb_interface)::set(null, "*", "vif", vif);
                run_test("test");
           end

endmodule
