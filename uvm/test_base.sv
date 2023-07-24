`include "counter_package.sv"
class test_base extends uvm_test;
  `uvm_component_utils(test_base)
  packet_sequence seq;
  environment env;
  
  function new(string name="test_base", uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment::type_id::create("env", this);
    seq = packet_sequence::type_id::create("seq");
  endfunction: build_phase
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction : end_of_elaboration_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    // seq = packet_sequence::type_id::create("seq");
    repeat(5) begin
      seq.start(env.agt.sqr);
    end
    #10;
    phase.drop_objection(this);
  endtask : run_phase
  
endclass : test_base