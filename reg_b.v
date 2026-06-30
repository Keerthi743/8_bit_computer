module reg_b (b,rst, load, clk, out);
  input [7:0] b;
  input rst;
  input load;
  input clk;
  output reg [7:0] out;

always @(posedge clk  or posedge rst)
    begin
      if (rst)
         out <= 8'b00000000;
      else if (load)
         out <= b;
     end
endmodule
  
          

