module ins_reg(clk, rst, data, out, operand, opcode, load);

input [7:0] data;
output reg [7:0] out;
output [3:0] operand, opcode;
input clk,rst,load;

always @(posedge clk)
 begin
  if(rst)
	out<=8'b0;
  else if(load)
	out<=data;
 end

assign opcode=out[7:4];
assign operand=out[3:0];

endmodule
