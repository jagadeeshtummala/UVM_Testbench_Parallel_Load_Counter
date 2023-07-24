class packet_sequence extends uvm_sequence#(packet);
  `uvm_object_utils(packet_sequence)
  //packet req; //Not needed packet handle defined in the UVM base class (uvm_sequence)
  
  function new(string name = "packet_sequence");
    super.new(name);
  endfunction : new
  
  // task pre_body();
  //   if(starting_phase != null ) starting_phase.raise_objection(this);
  // endtask : pre_body

  task body();
    //`uvm_info(get_type_name(), "Executing the Sequence in Sequence task Body", UVM_MEDIUM);
    `uvm_info(get_type_name(), "Executing Parallel Load Sequence", UVM_MEDIUM);
    repeat(10) begin
      `uvm_do_with(req, {parallel_load == 1; inc == 0;});
    end
    `uvm_info(get_type_name(), "Executing Increment Sequence", UVM_MEDIUM);
    repeat(10) begin
      `uvm_do_with(req, {parallel_load == 0; inc == 1;});
    end
    `uvm_info(get_type_name(), "Executing Decrement Sequence", UVM_MEDIUM);
    repeat(10) begin
      `uvm_do_with(req, {parallel_load == 0; inc == 0;});
    end
  endtask : body

  // task post_body();
  //   if(starting_phase != null ) starting_phase.raise_objection(this);
  // endtask: post_body
endclass : packet_sequence