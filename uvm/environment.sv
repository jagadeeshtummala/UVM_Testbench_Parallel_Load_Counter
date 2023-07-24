class environment extends uvm_env;
  `uvm_component_utils(environment)
  agent agt;
  scoreboard sb;
  function new(string name = "environment", uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = agent::type_id::create("agt", this);
    sb = scoreboard::type_id::create("sb", this);
  endfunction: build_phase
  
  function void connect_phase(uvm_phase phase);
    // uvm_top.print_topology();
    agt.mon.analysis_port.connect(sb.analysis_imp);
  endfunction : connect_phase
  
endclass : environment