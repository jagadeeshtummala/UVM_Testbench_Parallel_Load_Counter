class driver extends uvm_driver#(packet);
  `uvm_component_utils(driver)
  //Declare virtual interfcae handle
  virtual bus_interface vif;
  function new(string name="driver", uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    //`uvm_info("[BUILD]", this.print(), UVM_MEDIUM);
    if(!uvm_config_db#(virtual bus_interface)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Unable to retrieve Virtual Interface Handle from Config dB");
  endfunction : build_phase
      
      virtual task run_phase(uvm_phase phase);
        forever begin
          seq_item_port.get_next_item(req);
//           send(req);
          //Call the Interface Task instead
          vif.send(req);
          seq_item_port.item_done();
        end
      endtask : run_phase
  		
//      task send(packet tr);
//         //`uvm_info(get_type_name(), "Sending Packet from Driver", UVM_MEDIUM);
//         //tr.print();
//        @(negedge vif.clk);
//         vif.parallel_in <= tr.parallel_in;
//         vif.parallel_load <= tr.parallel_load;
//         vif.inc <= tr.inc;
//         vif.rst <= 0;
//       endtask : send
      
endclass : driver