module acc(clk,rst,A,LOAD,OUT);

input clk,rst,LOAD;
input [7:0]A;
output reg [7:0]OUT;

always @(posedge clk)
 begin
  if(rst)
	OUT<=8'b0;
  else if(LOAD)
	OUT<=A;
 end

endmodule