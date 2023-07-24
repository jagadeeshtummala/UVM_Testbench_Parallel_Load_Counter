interface bus_interface(input clk);
  logic [3:0] parallel_in;
  logic [3:0] out;
  logic parallel_load;
  logic inc;
  logic rst;
endinterface : bus_interface