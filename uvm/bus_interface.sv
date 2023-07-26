interface bus_interface(input clk);
  logic [3:0] parallel_in;
  logic [3:0] out;
  logic parallel_load;
  logic inc;
  logic rst;
  
  task send(packet tr);
    @(negedge clk);
        parallel_in <= tr.parallel_in;
        parallel_load <= tr.parallel_load;
        inc <= tr.inc;
        rst <= 0;
  endtask : send
    
endinterface : bus_interface