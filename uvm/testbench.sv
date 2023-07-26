
`timescale 1ns/100ps

`include "uvm_macros.svh"
import uvm_pkg::*;
`include "counter_package.sv"
`include "bus_interface.sv"
`include "test_base.sv"

module tb_top;
  bit clk=1;
  bit rst=0;
  always #10 clk = ~clk;
  bus_interface vif(clk);
  
  counter#(.WIDTH(4)) counter_0(.out(vif.out),.parallel_in(vif.parallel_in), .parallel_load(vif.parallel_load), 
                                .rst(rst), .clk(vif.clk), .inc(vif.inc));
  
  initial begin
    uvm_config_db#(virtual bus_interface)::set(uvm_root::get(), "*.env.agt.*", "vif", vif);
    $dumpfile("dump.vcd"); $dumpvars;
  end
  
  initial begin
    run_test(); //run_test("test_base");
  end
  
endmodule : tb_top