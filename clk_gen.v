module clk_gen(clk,reset,clk_out);

input clk;
input reset;
output reg clk_out;

reg [25:0] count;

always @(posedge clk)
begin

    if(reset)
     begin
        count <= 26'b0;
        clk_out <= 1'b0;
     end

    else if(count == 26'd49999999)
     begin
        count <= 26'b0;
        clk_out <= ~clk_out;
     end

    else
     begin
        count <= count+1'b1;
     end

end


endmodule