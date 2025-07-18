class reg1_reg extends uvm_reg;

     `uvm_object_utils(reg1_reg)

     rand uvm_reg_field reg1;

     function new(string name = "reg1_reg");

           super.new(name, 32, build_coverage(UVM_NO_COVERAGE));

     endfunction : new

     virtual function void build();

           reg1 = uvm_reg_field::type_id::create("reg1");
           reg1.configure(this, 32, 0, "rw", 0, 32'h0, 1, 1, 1);

     endfunction : build

endclass : reg1_reg


class reg2_reg extends uvm_reg;

     `uvm_object_utils(reg2_reg)

     rand uvm_reg_field reg2;

     function new(string name = "reg2_reg");

           super.new(name, 32, build_coverage(UVM_NO_COVERAGE));

     endfunction : new

     virtual function void build();

           reg2 = uvm_reg_field::type_id::create("reg2");
           reg2.configure(this, 32, 0, "rw", 0, 32'h0, 1, 1, 1);

     endfunction : build
     
endclass : reg2_reg


class reg3_reg extends uvm_reg;

     `uvm_object_utils(reg3_reg)

     rand uvm_reg_field reg3;

     function new(string name = "reg3_reg");

           super.new(name, 32, build_coverage(UVM_NO_COVERAGE));

     endfunction : new

     virtual function void build();

           reg3 = uvm_reg_field::type_id::create("reg3");
           reg3.configure(this, 32, 0, "rw", 0, 32'h0, 1, 1, 1);

     endfunction : build
     
endclass : reg3_reg


class reg4_reg extends uvm_reg;

     `uvm_object_utils(reg4_reg)

     rand uvm_reg_field reg4;

     function new(string name = "reg4_reg");

           super.new(name, 32, build_coverage(UVM_NO_COVERAGE));

     endfunction : new

     virtual function void build();

           reg4 = uvm_reg_field::type_id::create("reg4");
           reg4.configure(this, 32, 0, "rw", 0, 32'h0, 1, 1, 1);

     endfunction : build
     
endclass : reg4_reg