class scoreboard extends uvm_scoreboard;
  `uvm_component_utils(scoreboard)
  uvm_analysis_imp#(packet, scoreboard) analysis_imp;
   packet prev_packet, curr_packet;
  packet packet_queue[$];
  function new(string name="scoreboard", uvm_component parent);
    super.new(name, parent);
    analysis_imp = new("analysis_imp", this);
  endfunction : new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction : build_phase
  
  function void write(packet tr);
    //Implement Write Function
    packet_queue.push_back(tr);
//     tr.print();
//     if(prev_packet == null)
//       prev_packet = tr;
//     else if (curr_packet == null)
//       curr_packet = tr;
//     else begin
//       prev_packet = curr_packet;
//       curr_packet = tr;
//     end
  endfunction: write
  
  virtual task run_phase(uvm_phase phase);
//     packet prev_packet;
    //Implement run_phase task here   
    forever begin
    wait(packet_queue.size ==2);
    
    if(packet_queue.size ==2) begin
     
//       `uvm_info("SCRBD",$sformatf("%0t",$time),UVM_NONE);
      foreach(packet_queue[i]) begin
        packet_queue[i].print();
      end
      prev_packet = packet_queue.pop_front();
      
      curr_packet = packet_queue[0];
      //curr_packet.print();
      if(!compare_counter(prev_packet, curr_packet))
        `uvm_error("SCRBD Mismatch", "Output Mismatch with Reference Model");
        //`uvm_fatal("Scoreboard","Comparate Mismatch error, terminating the Simulation!!..");
      
    end
    end
  endtask: run_phase
  
  function bit compare_counter(packet prev, packet curr);
    if(curr.parallel_load) begin
      if(curr.parallel_in == curr.out) return 1;
      else return 0;
    end
    else if(curr.inc) begin
      if( curr.out == (prev.out + 1)%16 ) return 1;
      else return 0;
    end
    
    else begin
      if(curr.out == (prev.out-1)%16) return 1;
      else return 0;
    end
  endfunction : compare_counter
  
endclass: scoreboard