module output_register(
    input clk,
    input rst,
    input load,
    input [7:0] bus_in,
    output reg [7:0] out_data
);

always @(posedge clk or posedge rst)
begin
    if (rst)
        out_data <= 8'b00000000;
    else if (load)
        out_data <= bus_in;
end

endmodule