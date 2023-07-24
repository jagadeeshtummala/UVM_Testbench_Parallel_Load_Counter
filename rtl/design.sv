module counter #(parameter WIDTH=2)(out, parallel_in, parallel_load, rst, clk, inc);
  input [WIDTH-1:0] parallel_in;
  input clk, rst, parallel_load;
  input inc;
  output reg [WIDTH-1:0] out;
  
  always@(posedge clk) begin
    if(rst) begin
      out <= 'b0;
    end
    else if(parallel_load) begin
      	out <= parallel_in;
    end
    else begin
      out <= inc ? (out+1) : (out-1);
    end
    
  end
  
endmodule
