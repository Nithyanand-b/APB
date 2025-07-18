class reg_block extends uvm_reg_block;

           `uvm_object_utils(reg_block)  
    
           reg1_reg    reg1_1;
           reg2_reg    reg2_2;
           reg3_reg    reg3_3;
           reg4_reg    reg4_4;

           function new(string name = "reg_block");
                  super.new(name, build_coverage(UVM_NO_COVERAGE));
           endfunction

           virtual function void build();

                  default_map = create_map("default_map", 0, 4, UVM_LITTLE_ENDIAN, 0);

                  reg1_1 = reg1_reg::type_id::create("reg1_1");
                  reg1_1.build();  
                  reg1_1.configure(this, null);  
                  default_map.add_reg(reg1_1, 'h0, "RW");    // Address 0x0

                  reg2_2 = reg2_reg::type_id::create("reg2_2");
                  reg2_2.build();  
                  reg2_2.configure(this, null);  
                  default_map.add_reg(reg2_2, 'h4, "RW");    // Address 0x4

                  reg3_3 = reg3_reg::type_id::create("reg3_3");
                  reg3_3.build();  
                  reg3_3.configure(this, null);  
                  default_map.add_reg(reg3_3, 'h8, "RW");    // Address 0x8

                  reg4_4 = reg4_reg::type_id::create("reg4_4");
                  reg4_4.build();  
                  reg4_4.configure(this, null);  
                  default_map.add_reg(reg4_4, 'hC, "RW");    // Address 0xC

                  lock_model();

           endfunction

endclass
