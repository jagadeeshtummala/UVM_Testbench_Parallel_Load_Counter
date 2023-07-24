// Code your testbench here
// or browse Examples
// `timescale 1ns/100ps
// module test_bench;
//   parameter WIDTH=4;
//   reg clk, rst, inc;
//   reg parallel_load;
//   reg [WIDTH-1:0] parallel_in;
//   wire [WIDTH-1:0] out;
  
//   counter#(.WIDTH(4)) counter_0 (.out(out),.parallel_in(parallel_in), .parallel_load(parallel_load), 
//                            .rst(rst), .clk(clk), .inc(inc));
//   always #5 clk = ~clk;
//   initial begin
//     	clk = 0;
//     	parallel_load = 0;
//     	inc = 1;
//     	rst = 1;
//     @(negedge clk);
//     	rst = 0;
//     @(negedge clk);
//     	parallel_load = 1;
//     	parallel_in = 4'b1010;
//     @(negedge clk);
//     	parallel_load = 0;
//     @(negedge clk);
//     	inc = 0;
//     @(negedge clk);
//     @(negedge clk);
//     	inc = 1;
//     #100;
//     $finish;
    	
//   end
//   initial begin
//      $dumpfile("dump.vcd"); $dumpvars;
//   end
// endmodule
`timescale 1ns/100ps

`include "uvm_macros.svh"
import uvm_pkg::*;

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