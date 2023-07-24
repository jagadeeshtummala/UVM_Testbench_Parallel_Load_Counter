class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  uvm_analysis_port#(packet) analysis_port; //Declare a analysis port to connect to Scoreboard
  //Handle for Packet sequence item and virtual interface
  packet tr;
  virtual bus_interface vif;
  function new(string name = "monitor", uvm_component parent);
    super.new(name, parent);
    //tr = new();
    analysis_port = new("analysis_port", this);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual bus_interface)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Unable to retrieve Virtual Interface Handle from Config dB");
  endfunction : build_phase
     
  //Implement the Packet Collection in the Run Phase;
  virtual task run_phase(uvm_phase phase);
    forever begin
      //@(posedge vif.clk);
      @(posedge vif.clk);
      #1;
      tr = new();      
      tr.parallel_in = vif.parallel_in;
      tr.out = vif.out;
      tr.parallel_load = vif.parallel_load;
      tr.inc = vif.inc;
//       $display("In Monitor");
//       tr.print();
//       `uvm_info("Monitor",$sformatf("Pin: %0d, out: %0d, Pload: %0b, Inc: %0b",vif.parallel_in, vif.out, vif.parallel_load, vif.inc),UVM_MEDIUM);
      //@(negedge vif.clk);
      analysis_port.write(tr);
    end
  endtask : run_phase
endclass : monitor