class adapter extends uvm_reg_adapter;
       
       `uvm_object_utils(adapter)

       function new(string name = "adapter");
              super.new(name);
       endfunction : new

       function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
              
              transaction tr;
              tr = transaction::type_id::create("tr");

              tr.PWRITE = (rw.kind == UVM_WRITE) ? 1'b1 : 1'b0;
              tr.PADDR = rw.addr;
              tr.PWDATA = rw.data;

              return tr;
              
       endfunction : reg2bus


       function void bus2reg (uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
              
              transaction tr;

              assert ($cast(tr, bus_item));

              rw.kind = (tr.PWRITE == 1'b1) ? UVM_WRITE : UVM_READ;
              rw.data = (tr.PWRITE == 1'b1) ? tr.PWDATA : tr.PRDATA;
              rw.addr = tr.PADDR;
              rw.status = UVM_IS_OK;
              
       endfunction : bus2reg


endclass : adapter