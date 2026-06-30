module mar(
    input clk,
    input rst,
    input [3:0] addr,
    input load,
    output reg [3:0] out
);

always @(posedge clk)
begin
    if (rst)
        out <= 4'b0;

    else if (load)
        out <= addr;
end

endmodule