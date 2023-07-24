class packet extends uvm_sequence_item;
  rand bit [3:0] parallel_in;
  bit [3:0] out;
  rand bit parallel_load;
  rand bit inc;
  `uvm_object_utils_begin(packet)
  `uvm_field_int(parallel_in, UVM_ALL_ON)
  `uvm_field_int(out, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name="packet");
    super.new(name);
  endfunction
  
  function void print();
    `uvm_info("PACKET", $sformatf("Parallel In: %0d,out : %0d, parallel_load : %b, inc : %b", parallel_in, out, parallel_load, inc), UVM_MEDIUM);
  endfunction : print
endclass